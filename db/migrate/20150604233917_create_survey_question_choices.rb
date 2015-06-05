class CreateSurveyQuestionChoices < ActiveRecord::Migration
  def change
    create_table :survey_question_choices do |t|
    	t.string :name
    	t.integer :survey_question_id
    	
      t.timestamps null: false
    end
  end
end
