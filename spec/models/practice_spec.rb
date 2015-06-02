# == Schema Information
#
# Table name: practices
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe Practice do

  describe '.validations' do
    it { should validate_presence_of :name }
  end

  describe '.associations' do
    it { should have_many :users }
  end

end



