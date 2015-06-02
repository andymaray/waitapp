# == Schema Information
#
# Table name: patient_answers
#
#  id                 :integer          not null, primary key
#  patient_id         :integer
#  survey_question_id :integer
#  answer             :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PatientAnswer < ActiveRecord::Base
  attr_accessor :doctors_token

  belongs_to :patient
  belongs_to :survey_question

  delegate :question_type, to: :survey_question
end
