# == Schema Information
#
# Table name: presentations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bodypart_id :integer
#

require 'rails_helper'

describe Presentation do
  before :each do
    @presentation = create(:presentation)
    @bodypart = create(:bodypart)
    @survey_question = create(:survey_question)
  end

  describe '.associations' do
    it 'belongs to a bodypart' do
      @presentation.bodypart = @bodypart
      @presentation.save
      expect(@presentation.bodypart.name).to eq('head')
    end
    it 'has survey questions' do
      @presentation.survey_questions << @survey_question
      expect(@presentation.survey_questions.first.question).to match(/How would you describe the pain?/)
    end

    it { should have_many :patients }
  end

  describe '.validations' do
    it { should validate_presence_of :name }
  end

end

