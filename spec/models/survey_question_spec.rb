# == Schema Information
#
# Table name: survey_questions
#
#  id              :integer          not null, primary key
#  question        :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  presentation_id :string
#  mandatory       :boolean          default(FALSE)
#  question_type   :string
#

require 'rails_helper'

describe SurveyQuestion do
  before :each do
    @survey_question = create(:survey_question)
    @presentation = create(:presentation)
  end

  describe '.associations' do
    it 'belongs to a presentation' do
      @survey_question.presentation = @presentation
      @survey_question.save
      expect(@survey_question.presentation.name).to eq('headache')
    end

    it { should have_many :patient_answers }
    it { should have_many :patients }
    it { should accept_nested_attributes_for :patient_answers }
  end

  describe '.validations' do
    it { should validate_presence_of :question }
  end
end
