require 'rails_helper'

feature 'Category management' do
  let!(:category) { create(:category) }
  let!(:item) { create(:item, categories: [category]) }

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

    expect(page).to have_text(item.title)
    expect(page).to have_text(item.description)
  end

  scenario 'User clicks on an item on the category details page, and visits the item details page' do
    visit category_path(category)

    click_link item.id

    expect(page).to have_current_path(item_path(item))
  end
end