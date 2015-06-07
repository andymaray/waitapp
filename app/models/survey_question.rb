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

class SurveyQuestion < ActiveRecord::Base
  belongs_to :presentation
  belongs_to :language

  has_many :patient_answers
  has_many :patients, through: :patient_answers
  has_many :translates

  accepts_nested_attributes_for :patient_answers
  accepts_nested_attributes_for :translates, :reject_if => lambda { |a| a[:question].blank? }, allow_destroy: true

  validates :question, presence: true
  validates :language_id, presence: true

  delegate :name, to: :presentation, prefix: true

  serialize :choices

  QUESTION_TYPES = ['Text', 'Yes / No', 'Time', 'Choices']

  def self.all_with_presentations
    includes(:presentation).order(:presentation_id)
  end
end
