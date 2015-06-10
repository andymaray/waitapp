class RenamePatientAttributes < ActiveRecord::Migration
  def change
  	rename_column :patients, :first_name, :encrypted_first_name
  	rename_column :patients, :last_name, :encrypted_last_name
  	rename_column :patients, :user_name, :encrypted_user_name
  	rename_column :patients, :phone_number, :encrypted_phone_number
  	rename_column :patients, :gp_code, :encrypted_gp_code
  end
end
