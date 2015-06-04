class CreateTranslates < ActiveRecord::Migration
  def change
    create_table :translates do |t|
    	t.string	:question
    	t.integer	:language_id
    	t.integer	:survey_question_id
    	
      t.timestamps null: false
    end
  end
end
