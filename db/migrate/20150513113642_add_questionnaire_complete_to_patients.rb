class AddQuestionnaireCompleteToPatients < ActiveRecord::Migration
  def change
    add_column :patients, :questionnaire_complete, :boolean, default: false
  end
end
