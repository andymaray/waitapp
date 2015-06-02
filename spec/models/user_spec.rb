# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string
#  email                  :string
#  password_digest        :string
#  admin                  :boolean          default(FALSE)
#  clinician              :boolean          default(FALSE)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  practice_id            :string
#  password_reset_token   :string
#  password_reset_sent_at :datetime
#  super_user             :boolean          default(FALSE)
#

require 'rails_helper'

describe User do
  before :each do
    @user = create(:user)
  end
  it 'creates a user with valid name, email and matching passwords' do
    expect(@user).to be_valid
  end

  it 'is invalid without a name' do
    @user.name = nil
    expect(@user).not_to be_valid
  end

  it 'is invalid without an email' do
    @user.email = nil
    expect(@user).not_to be_valid
  end

  it 'is invalid with bad email format' do
    @user.email = "BadEmail"
    expect(@user).not_to be_valid
  end

  it 'expects matching passwords' do
    @user.password = 'password'
    @user.password_confirmation = "another-password"
    expect(@user).not_to be_valid
    @user.password_confirmation = 'password'
    expect(@user).to be_valid
  end

  it 'requires a unique email address' do
    @dup_user = User.new(
      name: 'Steve',
      email: @user.email,
      password: 'password',
      password_confirmation: 'password')
    expect(@dup_user).not_to be_valid
  end

  it '#find_local_clinicians' do
    @practice = create(:practice)
    @user.practice = @practice
    @user.save
    @users = User.all.find_local_clinicians(@user)
    expect(@users.first.practice_id).to eq(@user.practice_id)
    expect(@users.first.clinician).to be_truthy
  end

  describe '#send_password_reset' do
    before(:each) do
      @user = create(:user)
      @user.send_password_reset
    end

    it 'should generate a password reset token' do
      expect(@user.password_reset_token).to be_a(String)
    end

    it 'should generate password_reset_sent_at' do
      @user.reload
      expect(@user.password_reset_sent_at).to_not be_nil
    end

    it 'should email the password reset token to user' do
      expect(ActionMailer::Base.deliveries.last[:to].to_s).to eq(@user.email)
    end
  end
end
