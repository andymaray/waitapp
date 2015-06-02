class CreateBodyparts < ActiveRecord::Migration
  def change
    create_table :bodyparts do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
