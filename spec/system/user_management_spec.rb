require 'rails_helper'

describe 'User management' do
  context 'Guest' do
    scenario 'signs up' do
      visit root_path

      click_link 'Sign Up', match: :first

      fill_in 'E-mail', with: 'johndoe@example.com'
      fill_in 'Username', with: 'johndoe'
      fill_in 'Name', with: 'John Doe'
      fill_in 'Password', with: '123456'
      fill_in 'Password confirmation', with: '123456'
      click_button 'Sign Up'

      expect(page).to have_text('confirmation link has been sent')
    end

    scenario 'logs in' do
      password = '123456'
      user     = create(:user, password: '123456')

      visit root_path

      click_link 'Log In', match: :first

      fill_in 'E-mail', with: user.email
      fill_in 'Password', with: password
      click_button 'Log In'

      expect(page).to have_text('Signed in successfully.')
    end

    scenario 'visits a profile page' do
      user = create(:user)

      visit user_path(user)

      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'User' do
    let(:user) { create(:user) }

    before :each do
      sign_in user

      visit root_path
    end

    scenario 'logs out', js: true do
      click_link 'user-dropdown'
      click_link 'Log Out'

      expect(page).to have_link('Log In')
      expect(page).to have_text('Signed out')
    end

    scenario 'visits own profile', js: true do
      click_link 'user-dropdown'
      click_link 'Profile'

      expect(page).to have_current_path(user_path(user))
      expect(page).to have_text(user.name)
      expect(page).to have_text(user.email)
      expect(page).to have_text(user.username)
    end

    scenario 'visits the profile of another user' do
      another_user = create(:user)

      visit user_path(another_user)

      expect(page.status_code).to eq(404)
    end

    scenario 'edits information' do
      visit user_path(user)

      click_link 'Edit Info'

      new_email = 'new.email@example.com'
      new_name  = 'New Name'
      fill_in 'Email', with: new_email
      fill_in 'Name', with: new_name

      click_button 'update-info-button'

      user.reload
      expect(user.unconfirmed_email).to eq(new_email)
      expect(user.name).to eq(new_name)
    end

    scenario 'edits password' do
      visit user_path(user)

      click_link 'Edit Info'

      expect do
        fill_in 'Password', with: 'new_password'
        fill_in 'Password confirmation', with: 'new_password'
        fill_in 'Current password', with: user.password

        click_button 'update-password-button'
      end.to change { user.reload.encrypted_password }
    end
  end
end