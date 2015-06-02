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

FactoryGirl.define do
  factory :presentation do
    name 'headache'
    association :bodypart, factory: :bodypart
  end
end
