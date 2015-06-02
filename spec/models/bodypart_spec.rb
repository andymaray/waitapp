# == Schema Information
#
# Table name: bodyparts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Bodypart do

  before :each do
    @bodypart = create(:bodypart)
    @presentation = create(:presentation)
  end

  it 'takes survey questions' do
    @bodypart.presentations << @presentation
    @bodypart.save
    expect(@bodypart.presentation_ids.count).to eq(1)
  end


  describe '.validations' do
    it{ should validate_presence_of :name }
  end

  describe '.associations' do
    it { should have_many :presentations }
    it { should have_many :patients }
  end

end


