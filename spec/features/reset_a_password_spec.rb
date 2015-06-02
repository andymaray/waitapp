require 'spec_helper'

feature 'Password reset for Users' do
  background do
    @user = create(:user)
  end

  scenario 'User requests a password reset' do
    expect(@user.password_reset_token).to be_nil
    visit new_password_reset_path
    expect(page).to have_content 'Reset your password here'
    fill_in 'Email', with: @user.email
    click_button 'login'
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to eq(@user.email)
    expect(page).to have_content 'Instructions to reset your password have been sent to your email address.'
    @user.reload
    expect(@user.password_reset_token).to be_a(String)
    expect(current_url).to eq login_url
  end

  scenario 'User responds to password reset email' do
    @user.send_password_reset
    expect(@user.password_reset_token).to be_a(String)
    visit edit_password_reset_path(@user.password_reset_token)
    expect(page).to have_content 'Please reset your password here'
    fill_in 'Password', with: 'testtest', match: :prefer_exact
    fill_in 'Password confirmation', with: 'testtest', match: :prefer_exact
    click_button 'login'
    expect(page).to have_content "Password has been reset!"
    expect(current_url).to eq login_url
  end

  scenario 'Password and password confirmation don\'t match' do
    @user.send_password_reset
    visit edit_password_reset_path(@user.password_reset_token)
    fill_in 'Password', with: 'testtest', match: :prefer_exact
    fill_in 'Password confirmation', with: 'nonono', match: :prefer_exact
    click_button 'login'
    expect(page).to have_content "doesn't match Password"
  end

  scenario 'Email requesting password_reset_token doesn\'t exist in database' do
    visit new_password_reset_path
    fill_in 'Email', with: 'blah@example.com'
    click_button 'login'
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to_not eq('blah@example.com')
    expect(page).to have_content "Password reset failed."
    expect(current_url).to eq login_url
  end

  scenario 'Reset token has expired' do
    @user.send_password_reset
    expect(@user.password_reset_token).to be_a(String)
    expect(@user.password_reset_sent_at).to be > 2.hours.ago
    @user.update_attributes(password_reset_sent_at: 3.hours.ago)
    visit edit_password_reset_path(@user.password_reset_token)
    fill_in 'Password', with: 'testtest', match: :prefer_exact
    fill_in 'Password confirmation', with: 'testtest', match: :prefer_exact
    click_button 'login'
    expect(page).to have_content "Password reset has expired."
    expect(current_url).to eq new_password_reset_url
    expect(@user.password).to_not eq 'testtest'
  end

  scenario 'User visits url with invalid token' do
    visit edit_password_reset_path('INVALIDTOKEN')
    expect(page).to have_content "Invalid password reset token"
    expect(current_url).to eq login_url
  end
end
