class ChangeAppointmentTimeToDatetime < ActiveRecord::Migration
  def change
    remove_column :patients, :appointment_time
    add_column :patients, :appointment_time, :datetime
  end
end
