# == Schema Information
#
# Table name: practices
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Practice < ActiveRecord::Base
  has_many :users
  validates :name, presence: true
end
