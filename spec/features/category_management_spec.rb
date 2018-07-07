require 'rails_helper'

feature 'Category management' do
  scenario 'User visits the category page' do
    category1 = create(:category)
    category2 = create(:category)

    visit categories_path

    expect(page).to have_text(category1.title)
    expect(page).to have_text(category1.description)

    expect(page).to have_text(category2.title)
    expect(page).to have_text(category2.description)
  end
end