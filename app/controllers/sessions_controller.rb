class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      login(@user)
      redirect_to root_url, notice: "You have successfully logged in!"
    else
      flash.now[:alert] = 'Invalid email/password combination'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out"
  end
end
