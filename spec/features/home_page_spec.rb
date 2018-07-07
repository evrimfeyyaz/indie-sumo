require 'rails_helper'

feature 'Home page' do
  scenario 'User visits the home page' do
    visit root_path

    expect(page).to have_text('Category 1')
    expect(page).to have_text('Category 2')
  end
end