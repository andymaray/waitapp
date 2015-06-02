class PatientAnswerSubmissionMailer < ApplicationMailer
  layout 'user_mailer'
  default from: "submissions@waittap.com"
  def submission_confirmation(user, patient)
    @user = user
    @patient = patient
    @greeting = "Good day Dr #{@user.name}"
    @appointment_time = patient.appointment_time.strftime("%H:%M, %d %B %Y")
    mail(to: @user.email, subject: 'New information submitted via Waittap')
  end
end
