class RenameTypeToQuestionType < ActiveRecord::Migration
  def change
    rename_column :survey_questions, :type, :question_type
  end
end
