# == Schema Information
#
# Table name: presentations
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  bodypart_id :integer
#

class Presentation < ActiveRecord::Base
  belongs_to :bodypart
  has_many :patients
  has_many :survey_questions

  validates :name, presence: true

  delegate :name, to: :bodypart, prefix: true

  def self.all_with_bodyparts
    includes(:bodypart).order(:bodypart_id)
  end
end
