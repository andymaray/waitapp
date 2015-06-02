require 'rails_helper'

feature 'User token search' do

  before :each do
    @user = create(:user)
    @patient = create(:patient)
  end

  scenario 'user visits root and searches by their token - adjusted for non questionnaire submission' do
    visit root_url
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log In'
    fill_in 'patient_answer_doctors_token', with: @patient.token
    click_button 'Find'
    expect(current_path).to eq(patient_answer_path(@patient.token))
    expect(page).to have_content("The patient hasn't completed this form. Please wait until email confirmation before accessing.")
  end

  scenario 'user visits root and searches for invalid token' do
    visit root_url
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log In'
    fill_in 'patient_answer_doctors_token', with: 'rar'
    click_button 'Find'
    expect(page).to have_content(/Invalid token/)
    expect(current_path).to eq(root_path)
  end

end
