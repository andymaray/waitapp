class Translate < ActiveRecord::Base
	serialize :choices
	
	belongs_to :survey_question
	belongs_to :language

	validates :question, presence: true
  validates :language_id, presence: true
  validates :survey_question_id, presence: true
end
