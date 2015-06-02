class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :token

      t.timestamps null: false
    end
    add_index :patients, :token, unique: true
  end
end
