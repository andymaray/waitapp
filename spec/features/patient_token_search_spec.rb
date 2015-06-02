require 'rails_helper'

feature 'Patient token search' do

  before :each do
    @patient = create(:patient)
  end
  scenario 'patient visits root and searches by their token' do
    visit root_url
    fill_in 'bodypart_token', with: @patient.token
    click_button 'Go'
    expect(page).to have_content(/Bodypart/)
    expect(current_path).to eq(bodypart_path(@patient.token))
  end
  scenario 'patient visits root and searches for invalid token' do
    visit root_url
    fill_in 'bodypart_token', with: 'rar'
    click_button 'Go'
    expect(page).to have_content(/Invalid token/)
    expect(current_path).to eq(root_path)
  end
end
