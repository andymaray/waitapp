class BodypartsController < ApplicationController
  before_action :set_body_part, only: [:edit, :update, :destroy]
  before_filter :ensure_accessible_only_once, only: :show

  def index
    @bodyparts = Bodypart.all
  end

  def new
    @bodypart = Bodypart.new
  end

  def create
    if params[:bodypart][:token]
      if (@patient = Patient.find_by_token(params[:bodypart][:token]))
        redirect_to bodypart_url(@patient.token)
      else
        redirect_to root_url, alert: "Invalid token"
      end
    else
      @bodypart = Bodypart.new(bodypart_params)
      if @bodypart.save
        redirect_to bodyparts_path, notice: "Bodypart created"
      else
        render :new, notice: "Please try again"
      end
    end
  end

  def show
    @patient = Patient.find_by(user_name: params[:id])
  end

  def edit
  end

  def update
    if @bodypart.update_attributes(bodypart_params)
      redirect_to @bodypart, notice: "Bodypart updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def destroy
    @bodypart.destroy
    redirect_to root_url, notice: "Bodypart deleted"
  end

  private

    def submit_finder_form(token_type, path)
      if (@patient = Patient.find_by_token(params[:bodypart][token_type.to_sym]))
        redirect_to path(@patient.token)
      else
        redirect_to root_url, alert: "Invalid token"
      end
    end

    def bodypart_params
      params.require(:bodypart).permit(:name, :token)
    end

    def set_body_part
      @bodypart = Bodypart.find(params[:id])
    end

    def ensure_accessible_only_once
      @patient =  current_patient
      if @patient && @patient.questionnaire_complete?
          redirect_to root_url, notice: "For security reasons, you can only access questionair data once. Please contact your practice if you need anything further."
      end
    end

    def assign_patient_or_redirect
      unless(@patient = Patient.find_by_token(params[:id]))
        redirect_to root_url, alert: "Invalid token."
      end
    end
end
