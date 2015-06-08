class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show, :destroy]
  before_filter :ensure_correct_user, only: [:edit, :update, :show]
  before_filter :restrict_to_admins, only: [:new, :create]

  def index
    @users = if current_user && current_user.super_user
      User.all_with_practice
    elsif current_user
      User.where(practice: current_user.practice)
    end
    # The line below needs to be relocated to the eventual patient home page - presumeably just a static
    @patient = Patient.new
    @local_clinicians = User.where(clinician: true)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.practice_id = current_user.practice_id
    if @user.save
      redirect_to root_url, notice: "User created"
    else
      render :new, alert: "Please try again"
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_url, notice: "User updated"
    else
      render :edit, alert: "Please try again"
    end
  end

  def show
    @user_patients = @user.feed
    @survey_questions = SurveyQuestion.all
  end

  def destroy
    @user.destroy
    redirect_to root_url, notice: "User deleted"
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :clinician, :admin)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def ensure_correct_user
      unless current_user.super_user
        unless (current_user && current_user.id) == params[:id].to_i
          redirect_to root_url, alert: "You can only access your own profile"
        end
      end
    end

    def restrict_to_admins
      unless current_admin
        redirect_to root_url, alert: "Only administrators can access this resource"
      end
    end
end
