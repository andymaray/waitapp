class AddChoicesToTranslates < ActiveRecord::Migration
  def change
    add_column :translates, :choices, :string
  end
end
