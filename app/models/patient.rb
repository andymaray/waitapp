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

class Patient < ActiveRecord::Base
  belongs_to :user
  belongs_to :bodypart
  belongs_to :presentation
  has_many :patient_answers
  has_many :survey_questions, through: :patient_answers
  has_many :appointments, dependent: :destroy

  validates_presence_of :first_name, :last_name, :gp_code

  accepts_nested_attributes_for :patient_answers, update_only: true
  accepts_nested_attributes_for :appointments, allow_destroy: true

  # delegate :name, to: :user, prefix: true
  delegate :name, to: :bodypart, prefix: true
  delegate :name, to: :presentation, prefix: true

  before_update :stringify_array_answers, only: :update

  after_create :assign_username

  def assign_username
    self.user_name = self.first_name + "-" + self.id.to_s
    self.save!
  end

  def full_name
    self.first_name + " " + self.last_name
  end
  private
    def stringify_array_answers
      self.patient_answers.each do |pa|
        unless pa.question_type == 'Time'
          pa.answer.gsub!(/[^0-9a-z ]/i, '') if pa.answer.present?
        end
      end
    end

  def self.todays_tokens
    where("created_at >= ?", Time.zone.now.beginning_of_day).order(:appointment_time)
  end
end
