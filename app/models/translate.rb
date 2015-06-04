class Translate < ActiveRecord::Base
	belongs_to :survey_questions
	belongs_to :language

	validates :question, presence: true
  validates :language_id, presence: true
  validates :survey_question_id, presence: true
end
