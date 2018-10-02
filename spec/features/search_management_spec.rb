require 'rails_helper'

feature 'Search management' do
  scenario 'User searches a resource by title' do
    search_term = 'Paul Graham'

    resource1 = create(:resource, title: search_term)
    resource2 = create(:resource, title: 'Not Important')

    visit root_path

    fill_in 'Search', with: search_term
    click_button 'Search'

    expect(page).to have_current_path(search_path)

    within '#search-results' do
      expect(page).to have_text(resource1.title)
      expect(page).to have_text(search_term)
      expect(page).not_to have_text(resource2.title)
    end
  end
end