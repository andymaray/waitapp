class Appointment < ActiveRecord::Base
	belongs_to :patient
	belongs_to :user

	 validates_presence_of :appointment_time, :user_id

	private
	
	def self.search_by_date(start_date, end_date, page)
    start_date = Date.parse(start_date).beginning_of_day
    end_date = Date.parse(end_date).end_of_day
    where(created_at: start_date..end_date).paginate(page: page, per_page: 10).order("created_at desc")
  end
end
