class PatientsController < ApplicationController
  before_filter :restrict_to_admins, only: [:index]
  def index
    appointments = find_appointments
    if params[:search]
      @appointments = appointments.search_by_date(params[:start_date], params[:end_date], params[:page])
    else
      @appointments = appointments.paginate(page: params[:page], per_page: 10).order("created_at desc")
    end
  end

  def new
    @patient = Patient.new
    @local_clinicians = User.where(clinician: true)
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      remember_patient(@patient)
      redirect_to bodypart_path(@patient.user_name)
    else
      @local_clinicians = User.where(clinician: true)
      render :new
    end
  end

  def update
    @patient = current_patient
    begin
      if @patient.update_attributes(patient_params)
        if params[:patient_answer_page]
          redirect_to patient_answer_path(@patient.user_name), notice: "Thank you for submitting your form. See you at the appointment"
        elsif params[:survey_question_page]
          redirect_to survey_question_url(@patient.user_name), notice: "Here are your questions"
        elsif @patient.bodypart_id
          redirect_to presentation_url(@patient.user_name), notice: "Now specify your problem"
        end
      else
        if @patient.form_reached
          render survey_question_url(@patient.user_name)
          flash.now[:alert] = "Please try again"
        elsif @patient.bodypart_id
          render presentation_url(@patient.user_name)
          flash.now[:alert] = "Please try again"
        else
          render bodypart_url(@patient.user_name)
          flash.now[:alert] = "Not updated - please try again"
        end
      end
    rescue ActionController::ParameterMissing => e
      logger.error("Logged error: #{e.message}")
      redirect_to bodypart_url(@patient.user_name), alert: "Incorrect submission, please try again."
    end
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def todays_token
    @patients = Patient.todays_tokens
  end

  private
    def patient_params
      params.require(:patient).permit(
        :appointment_time,
        :questionnaire_complete,
        :user_id,
        :bodypart_id,
        :presentation_id,
        :first_name,
        :last_name,
        :gp_code,
        :phone_number,
        :user_name,
        patient_answers_attributes: [:answer, { answer: [] }, :id],
        appointments_attributes: [:id, :appointment_time, :user_id, :patient_id]
      )
    end

    def find_appointments
      if params[:clinician_id].present?
        user = User.find(params[:clinician_id])
        user.appointments
      else
        Appointment
      end
    end

    def restrict_to_admins
      if !current_admin && !params[:clinician_id].present?
        redirect_to root_url, alert: "Only administrators can access this resource"
      end
    end
end
