# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  password_digest        :string
#  admin                  :boolean          default(FALSE)
#  clinician              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  practice_id            :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  super_user             :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :user do
    name "Steve"
    sequence(:email) { |n| "steve#{n}@example.com"}
    password "password"
    password_confirmation "password"
    admin true
    clinician true
    association :practice, factory: :practice, name: "Hell"
  end

  factory :admin, class: User do
    name "Admin"
    admin true
  end

  factory :receptionist, class: User do
    name "Receiption"
    clinician false
  end

  factory :user_from_another_hospital, class: User do
    name "Not local"
    clinician true
    association :practice, factory: :practice, name: "Shelbyville"
  end

  factory :invalid_user do
    name "Steve"
    sequence(:email) { |n| "steve#{n}@example.com"}
    password "password"
    password_confirmation "pass"
    admin false
    clinician true
    association :practice, factory: :practice, name: "Hell"
  end
end
