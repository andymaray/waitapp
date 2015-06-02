# == Schema Information
#
# Table name: bodyparts
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Bodypart < ActiveRecord::Base
  attr_accessor :token

  has_many :presentations
  has_many :patients
  validates :name, presence: true
end
