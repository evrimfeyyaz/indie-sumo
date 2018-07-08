require 'rails_helper'

feature 'Category management' do
  scenario 'User visits the category index' do
    category1 = create(:category)
    category2 = create(:category)

    visit categories_path

    expect(page).to have_text(category1.title)
    expect(page).to have_text(category1.description)

    expect(page).to have_text(category2.title)
    expect(page).to have_text(category2.description)
  end

  scenario 'User clicks on a category on the index, and visits the category details page' do
    category = create(:category)

    visit categories_path

    click_link category.id

    expect(page).to have_current_path(category_path(category))
    expect(page).to have_text(category.title)
    expect(page).to have_text(category.description)
  end
end