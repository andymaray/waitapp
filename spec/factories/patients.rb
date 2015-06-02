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

FactoryGirl.define do
  factory :patient do
    token SecureRandom.urlsafe_base64(5)
    appointment_time "2015-05-11 13:58:00"
    association :user, factory: :user, name: "Dirk"
  end
end
