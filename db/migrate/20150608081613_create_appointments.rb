class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
    	t.datetime :appointment_time
    	t.integer :user_id
    	t.integer	:patient_id
    	
      t.timestamps null: false
    end
  end
end