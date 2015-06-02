class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.text :question

      t.timestamps null: false
    end
  end
end
