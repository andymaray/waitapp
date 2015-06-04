class Language < ActiveRecord::Base
	has_many :survey_questions
	has_many :translates
end
