class AddBodypartIdAndPresentationIdToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :bodypart_id, :integer
    add_column :patients, :presentation_id, :integer
  end
end
