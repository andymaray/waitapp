# == Schema Information
#
# Table name: practices
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :practice do
    name "Podmedics Surgery"

    factory :user_with_practice do
      after(:create) do |practice|
        create(:user, practice: practice)
      end
    end
  end
end
