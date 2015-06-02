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

  validates_presence_of :user_id, :appointment_time

  accepts_nested_attributes_for :patient_answers, update_only: true


  delegate :name, to: :user, prefix: true
  delegate :name, to: :bodypart, prefix: true
  delegate :name, to: :presentation, prefix: true

  before_update :stringify_array_answers, only: :update

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

  def self.search_by_date(start_date, end_date, page)
    start_date = Date.parse(start_date).beginning_of_day
    end_date = Date.parse(end_date).end_of_day
    where(created_at: start_date..end_date).paginate(page: page, per_page: 10).order("created_at desc")
  end
end
