require 'rails_helper'

feature 'OAuth management' do
  context 'User visits the login page' do
    before :each do
      visit root_url
      click_link 'Log In', match: :first
    end

    scenario 'and logs in using Facebook', :oauth do
      username = 'johndoe'

      click_link 'Log in with Facebook'
      fill_in 'Username', with: username
      click_button 'Sign Up'

      expect(User.last.username).to eq(username)
      expect(page).not_to have_link('Log In')
    end

    scenario 'and logs in using Facebook without giving e-mail permission', :oauth_no_email do
      username = 'johndoe'
      email    = 'johndoe@example.com'

      click_link 'Log in with Facebook'
      fill_in 'Username', with: username
      fill_in 'Email', with: email
      click_button 'Sign Up'

      expect(User.last.username).to eq(username)
      expect(User.last.email).to eq(email)
      expect(page).to have_text('You have to confirm your email')
    end
  end
end