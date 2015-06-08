class Appointment < ActiveRecord::Base
	belongs_to :patient
	belongs_to :user

	 validates_presence_of :appointment_time, :user_id
end
