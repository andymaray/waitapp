class AddTypeToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :type, :string
  end
end
