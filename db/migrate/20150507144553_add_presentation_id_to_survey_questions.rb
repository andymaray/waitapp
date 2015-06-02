class AddPresentationIdToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :presentation_id, :string
  end
end
