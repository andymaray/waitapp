class AddAppointmentTimeToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :appointment_time, :string
    add_column :patients, :user_id, :integer
  end
end
