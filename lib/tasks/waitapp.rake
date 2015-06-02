namespace :waitapp do
  task add_dummy_patients: :environment do
    users = User.where(clinician: true)
    count = 0
    total_records = 25
    until count > total_records  do
      patient = Patient.new
      user = users.order('RANDOM()').first
      patient.appointment_time = DateTime.new(2015,6,5)
      patient.user = user
      patient.token = SecureRandom.urlsafe_base64(4)
      patient.save!
      count+=1
    end
  end
end