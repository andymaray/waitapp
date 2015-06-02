require 'rails_helper'

feature 'User management' do

  before do
    @user = create(:user)
    @wrong_user = create(:user)
    @wrong_id = @wrong_user.id
    visit root_url
    click_link 'Log in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log In'
  end

  scenario 'signs in, tries to edit the wrong user' do
    visit edit_user_path(@user)
    expect(page).to have_content 'Edit user'
    visit edit_user_path(@wrong_id)
    expect(page).to have_content 'You can only access your own profile'
  end

  scenario 'super user can edit anyone' do
    @user.update_attributes(super_user: true)
    visit edit_user_path(@wrong_id)
    expect(page).to have_content 'Edit user'
  end

end
