class UserMailer < ActionMailer::Base
  default from: "info@waittap.com"

  def password_reset(user)
    @user = user
    mail(to: @user.email, subject: 'Waittap - Password Reset')
  end

  def send_token(user, patient)
    @user = user
    @patient = patient
    mail(to: @user.email, subject: 'Waittap - Token Generated')
  end
end
