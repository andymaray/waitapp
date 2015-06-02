# == Schema Information
#
# Table name: patients
#
#  id                     :integer          not null, primary key
#  token                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  user_id                :integer
#  bodypart_id            :integer
#  presentation_id        :integer
#  form_reached           :boolean
#  appointment_time       :datetime
#  questionnaire_complete :boolean          default(FALSE)
#

require 'rails_helper'

describe Patient do

  describe '.validations' do
    it{ should validate_presence_of :appointment_time}
    it{ should validate_presence_of :user_id }
  end

  it { should belong_to :user}
  it { should belong_to :bodypart}
  it { should belong_to :presentation }

  it { should have_many :patient_answers}
  it { should have_many :survey_questions}


  describe '#user_name' do
    it "returns the associated user name" do
      # code in here
    end
  end

end
