require 'rails_helper'

feature 'Patient journey' do
  scenario 'Patient responds to receiving token' do
    patient = create(:patient)
    survey_question = create(:survey_question)
    expect(patient.bodypart_id).to be_nil
    expect(patient.presentation_id).to be_nil
    visit bodypart_path(patient.token)
    expect(page).to have_content(/Bodypart/)
    Capybara.ignore_hidden_elements = false
    choose("head")
    click_button "Next"
    patient.reload
    expect(patient.bodypart_id).to be_truthy
    expect(page).to have_content(/Presentation/)
    Capybara.ignore_hidden_elements = true
    select 'headache', from: 'patient_presentation_id'
    click_button 'Next'
    patient.reload
    expect(patient.presentation_id).to be_truthy
    expect(page).to have_content('Here are your questions')
    expect(patient.form_reached).to be_truthy
    fill_in 'patient_patient_answers_attributes_0_answer', with: "Severe"
    click_button 'Submit'
    expect(ActionMailer::Base.deliveries.last[:to].to_s).to be_truthy
    expect(page).to have_content(/Severe/)
    expect(page).to have_content(/Thank you for submitting your form. See you at the appointment/)
    patient.reload
    expect(patient.questionnaire_complete).to be_truthy
    visit bodypart_path(patient.token)
    expect(current_path).to eq(root_path)
    expect(page).to have_content(/For security reasons, you can only access token data once. Please contact your practice if you need anything further./)
  end
end
