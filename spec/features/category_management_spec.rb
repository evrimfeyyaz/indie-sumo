require 'rails_helper'

feature 'Category management' do
  let!(:category) { create(:category) }
  let!(:resource) { create(:resource, categories: [category]) }

  scenario 'User visits the home page' do
    visit root_path

    expect(page).to have_text(category.title)
    expect(page).to have_text(category.description)
  end

  scenario 'User clicks on a category on the home page, and visits the category details page' do
    visit root_path

    click_link category.id

    expect(page).to have_current_path(category_path(category))
    expect(page).to have_text(category.title)
    expect(page).to have_text(category.description)

    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.description)
  end

  scenario 'User clicks on a resource on the category details page, and visits the resource details page' do
    visit category_path(category)

    click_link resource.id

    expect(page).to have_current_path(resource_path(resource))
  end
end