class PatientsController < ApplicationController
  before_filter :restrict_to_admins, only: [:index]
  def index
    patients = find_patients
    if params[:search]
      @patients = patients.search_by_date(params[:start_date], params[:end_date], params[:page])
    else
      @patients = patients.paginate(page: params[:page], per_page: 10).order("created_at desc")
    end
  end

  def new
    @patient = Patient.new
    if current_user
      @local_clinicians = User.find_local_clinicians(current_user)
    else
      redirect_to root_url, notice: 'Please login to create new tokens'
    end
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.user && @patient.user.clinician
      if @patient.valid?
        @patient.token = SecureRandom.urlsafe_base64(4)
        @patient.save
        UserMailer.send_token(current_user, @patient).deliver_now
        redirect_to @patient, notice: 'New token generated - please forward to the patient. A copy will be emailed to you for your records.'
      else
        redirect_to new_patient_url, alert: "A patient must have an appointment time and date."
      end
    else
      redirect_to new_patient_url, alert: "A patient must be assigned to a clinician"
    end
  end

  def update
    @patient = current_patient
    begin
      if @patient.update_attributes(patient_params)
        if @patient.form_reached
          PatientAnswerSubmissionMailer.submission_confirmation(@patient.user, @patient).deliver_now
          redirect_to patient_answer_path(@patient.token), notice: "Thank you for submitting your form. See you at the appointment"
        elsif @patient.presentation_id
          redirect_to survey_question_url(@patient.token), notice: "Here are your questions"
        elsif @patient.bodypart_id
          redirect_to presentation_url(@patient.token), notice: "Now specify your problem"
        end
      else
        if @patient.form_reached
          render survey_question_url(@patient.token)
          flash.now[:alert] = "Please try again"
        elsif @patient.bodypart_id
          render presentation_url(@patient.token)
          flash.now[:alert] = "Please try again"
        else
          render bodypart_url(@patient.token)
          flash.now[:alert] = "Not updated - please try again"
        end
      end
    rescue ActionController::ParameterMissing => e
      logger.error("Logged error: #{e.message}")
      redirect_to bodypart_url(@patient.token), alert: "Incorrect submission, please try again."
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
        patient_answers_attributes: [:answer, { answer: [] }, :id]
      )
    end

    def find_patients
      if params[:clinician_id].present?
        user = User.find(params[:clinician_id])
        user.patients
      else
        Patient
      end
    end

    def restrict_to_admins
      if !current_admin && !params[:clinician_id].present?
        redirect_to root_url, alert: "Only administrators can access this resource"
      end
    end
end
