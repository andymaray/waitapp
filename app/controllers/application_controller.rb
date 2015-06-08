class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authorise
  delegate :allow?, to: :current_permission
  helper_method :allow?

  def login(user)
    session[:user_id] = user.id
  end

  def remember_patient(patient)
    session[:patient_id] = patient.id
  end

  def formatted_time(patient)
    @appointment_time = patient.appointment_time.strftime("%H:%M, %d %B %Y")
  end
  helper_method :formatted_time

  private

    def current_permission
      @current_permission ||= Permission.new(current_user)
    end

    def authorise
      unless current_permission.allow?(params[:controller], params[:action], current_patient)
        redirect_to root_url, alert: 'You are not authorized'
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    def current_patient
      @current_patient ||= Patient.find(session[:patient_id]) if session[:patient_id]
    end
    helper_method :current_patient

    def current_admin
      (current_user && current_user.admin?) ? current_user : false
    end
    helper_method :current_admin

    def user_signed_in?
      current_user?
    end
    helper_method :user_signed_in?
end
