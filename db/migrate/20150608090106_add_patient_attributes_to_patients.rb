class AddPatientAttributesToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :first_name, :string
    add_column :patients, :last_name, :string
    add_column :patients, :user_name, :string
    add_column :patients, :phone_number, :string
    add_column :patients, :gp_code, :string
  end
end
