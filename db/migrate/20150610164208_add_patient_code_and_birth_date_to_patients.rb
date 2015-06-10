class AddPatientCodeAndBirthDateToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :encrypted_birth_date, :string
    add_column :patients, :encrypted_patient_code, :string
  end
end
