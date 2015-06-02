class AddFormReachedToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :form_reached, :boolean
  end
end
