class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:edit, :update, :destroy]
  before_filter :assign_patient_or_redirect, only: :show
  before_filter :ensure_accessible_only_once, only: :show

  def index
    @presentations = Presentation.all_with_bodyparts
  end

  def new
    @presentation = Presentation.new
  end

  def create
    @presentation = Presentation.new(presentation_params)
    if @presentation.save
      redirect_to presentations_path, notice: "Presentation created"
    else
      render :new, alert: "Please try again"
    end
  end

  def show
    @presentations = Presentation.where(bodypart_id: @patient.bodypart_id)
  end

  def edit
  end

  def update
    if @presentation.update_attributes(presentation_params)
      redirect_to presentations_path, notice: "Presentation updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def destroy
    @presentation.destroy
    redirect_to presentations_path, notice: "Presentation deleted"
  end

  private
    def presentation_params
      params.require(:presentation).permit(:name, :description, :bodypart_id)
    end

    def set_presentation
      @presentation = Presentation.find(params[:id])
    end

    def ensure_accessible_only_once
      @patient = Patient.find_by_token(params[:id]) || current_patient
      if @patient && @patient.questionnaire_complete?
          redirect_to root_url, notice: "For security reasons, you can only access token data once. Please contact your practice if you need anything further."
      end
    end

    def assign_patient_or_redirect
      unless(@patient = Patient.find_by_user_name(params[:id]))
        redirect_to root_url, alert: "Invalid token."
      end
    end
end
