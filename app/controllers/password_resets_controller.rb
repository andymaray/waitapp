class PasswordResetsController < ApplicationController
  before_filter :set_user_or_redirect, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.send_password_reset
      redirect_to login_url, notice: "Instructions to reset your password have been sent to your email address."
    else
      redirect_to login_url, alert: "Password reset failed."
    end
  end

  def edit
    set_user_or_redirect
  end

  def update
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_url, alert: "Password reset has expired."
    elsif @user.update_attributes(password_resets_params)
      redirect_to login_url, notice: "Password has been reset!"
    else
      render :edit
    end
  end

  private

    def set_user_or_redirect
      @user = User.find_by_password_reset_token(params[:id])
      unless @user
        redirect_to login_url, alert: "Invalid password reset token"
      end
    end

    def password_resets_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
