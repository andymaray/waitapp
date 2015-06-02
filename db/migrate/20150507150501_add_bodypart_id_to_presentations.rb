class AddBodypartIdToPresentations < ActiveRecord::Migration
  def change
    add_column :presentations, :bodypart_id, :integer
  end
end
