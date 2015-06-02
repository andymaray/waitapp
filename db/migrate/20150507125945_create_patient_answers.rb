class CreatePatientAnswers < ActiveRecord::Migration
  def change
    create_table :patient_answers do |t|
      t.integer :patient_id
      t.integer :survey_question_id
      t.string :answer

      t.timestamps null: false
    end
  end
end
