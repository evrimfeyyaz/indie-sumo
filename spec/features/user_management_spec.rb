require 'rails_helper'

feature 'User management' do
  scenario 'Guest signs up' do
    visit root_path

    click_link 'Sign Up', match: :first

    fill_in 'E-mail', with: 'johndoe@example.com'
    fill_in 'Username', with: 'johndoe'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    click_button 'Sign Up'

    expect(page).to have_text('confirmation link has been sent')
  end

  scenario 'Guest logs in' do
    password = '123456'
    user = create(:user, password: '123456')

    visit root_path

    click_link 'Log In', match: :first

    fill_in 'E-mail', with: user.email
    fill_in 'Password', with: password
    click_button 'Log In'

    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'User logs out', js: true do
    user = create(:user)
    sign_in user

    visit root_path

    # For some reason, Capybara can't find the "Log Out" link, hence the monstrosity below.
    page.find('#log-out-link', visible: :false).trigger(:click)

    expect(page).to have_link('Log In')
    expect(page).to have_text('Signed out')
  end
end