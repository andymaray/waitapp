class AddLanguageIdToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :language_id, :integer
  end
end
