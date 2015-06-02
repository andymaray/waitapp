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

FactoryGirl.define do
  factory :survey_question do
    question "How would you describe the pain?"
    association :presentation, factory: :presentation
  end
end
