# == Schema Information
#
# Table name: bodyparts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :bodypart do
    name :head
  end
end
