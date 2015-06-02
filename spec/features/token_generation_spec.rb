require 'rails_helper'

feature 'Token generation' do

  background do
    @user = create(:user)
    visit root_url
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log In'
    visit new_patient_path
  end

  scenario 'creates a token with a time and a doctor' do
    fill_in 'patient_appointment_time', with: Time.now
    select 'Steve', from: 'patient_user_id'
    expect { click_button "Create Token" }.to change(Patient, :count)
    expect(page).to have_content(/New token generated/)
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to eq(@user.email)
  end

  scenario 'creates a token with a missing doctor' do
    fill_in 'patient_appointment_time', with: Time.now
    expect { click_button "Create Token" }.to_not change(Patient, :count)
    expect(page).to have_content('A patient must be assigned to a clinician')
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to_not eq(@user.email)
  end

  scenario 'creates a token with no appointment time' do
    select 'Steve', from: 'patient_user_id'
    expect { click_button "Create Token" }.to_not change(Patient, :count)
    expect(page).to have_content('A patient must have an appointment time and date.')
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to_not eq(@user.email)
  end

end
