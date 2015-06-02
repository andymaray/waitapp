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

require 'rails_helper'

describe PatientAnswer do

  describe '.associations' do
    it { should belong_to :patient }
    it { should belong_to :survey_question }
  end

end
