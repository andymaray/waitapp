class SurveyQuestionsController < ApplicationController
  layout 'questionnaire'
  before_action :set_survey_question, only: [:edit, :update, :destroy]
  before_filter :assign_patient_or_redirect, only: :show
  before_filter :ensure_accessible_only_once, only: :show

  def index
    @survey_questions = SurveyQuestion.all_with_presentations
  end

  def new
    @survey_question = SurveyQuestion.new
  end

  def create
    @survey_question = SurveyQuestion.new(survey_question_params)
    if @survey_question.save
      redirect_to survey_questions_path, notice: "Survey Question created"
    else
      render :new, alert: "Please try again"
    end
  end

  def show
      @survey_questions = SurveyQuestion.where(presentation_id: @patient.presentation_id)
      @mandatory_questions = SurveyQuestion.where(mandatory: true)
      @survey_questions << @mandatory_questions
      if @patient.survey_questions.empty?
        @patient.form_reached = true
        @patient.survey_questions << @survey_questions
        @patient.save
      end
      @patient_answers = PatientAnswer.where(patient_id: @patient.id)
  end

  def edit
  end

  def update
    if @survey_question.update_attributes(survey_question_params)
      redirect_to survey_questions_path, notice: "Survey Question updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def destroy
    @survey_question.destroy
    redirect_to survey_questions_path, notice: "SurveyQuestion deleted"
  end

  private

    def survey_question_params
      params.require(:survey_question).permit(:question, :question_type, :mandatory, :presentation_id, :language_id)
    end

    def set_survey_question
      @survey_question = SurveyQuestion.find(params[:id])
    end

    def ensure_accessible_only_once
      @patient = Patient.find_by_token(params[:id]) || current_patient
      if @patient && @patient.questionnaire_complete?
          redirect_to root_url, notice: "For security reasons, you can only access token data once. Please contact your practice if you need anything further."
      end
    end

    def assign_patient_or_redirect
      unless(@patient = Patient.find_by_token(params[:id]))
        redirect_to root_url, alert: "Invalid token."
      end
    end
end
