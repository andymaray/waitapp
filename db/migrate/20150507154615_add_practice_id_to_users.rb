class AddPracticeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :practice_id, :string
  end
end
