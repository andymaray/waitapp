class AddChoicesToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :choices, :text
  end
end
