class PatientAnswersController < ApplicationController

  def create
    if (@patient = Patient.find_by_token(params[:patient_answer][:doctors_token]))
      redirect_to patient_answer_url(@patient.token)
    else
      redirect_to root_url, alert: "Invalid token"
    end
  end

  def show
    if current_patient || current_user
      assign_patient_or_redirect
      @patient_answers = PatientAnswer.where(patient_id: @patient.id)
      @survey_questions = SurveyQuestion.all
      session[:patient_id] = nil
    else
      redirect_to root_url, notice: "For security purposes, you may only access submitted information once.
                                    \nPlease contact your practice if you have any issues.
                                    \nIf you're a doctor visiting this page, please login and try again."
    end
  end

  private

    def assign_patient_or_redirect
      unless(@patient = Patient.find_by(user_name: params[:id]))
        redirect_to root_url, alert: "Invalid token."
     end
    end
end
