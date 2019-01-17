require 'rails_helper'

describe 'Search management' do
  scenario 'Visitor searches a resource by title' do
    search_term = 'paul'

    resource1 = create(:resource, title: search_term)
    resource2 = create(:resource, title: 'Not Important')

    visit root_path

    within '.navigation' do
      fill_in 'Search', with: search_term
      click_button 'Search'
    end

    expect(page).to have_current_path(search_path, ignore_query: true)

    save_page

    within '#search-results' do
      expect(page).to have_text(resource1.title)
      expect(page).not_to have_text(resource2.title)
    end
  end

  scenario 'Visitor searches a resource by description' do
    search_term = 'some'

    resource1 = create(:resource, description: 'Some description here.')
    resource2 = create(:resource, title: 'Not Important')

    visit root_path

    within '.navigation' do
      fill_in 'Search', with: search_term
      click_button 'Search'
    end

    expect(page).to have_current_path(search_path, ignore_query: true)

    save_page

    within '#search-results' do
      expect(page).to have_text(resource1.title)
      expect(page).not_to have_text(resource2.title)
    end
  end
end