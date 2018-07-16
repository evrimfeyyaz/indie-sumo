require 'rails_helper'

feature 'Item management' do
  scenario 'User visits an item details page' do
    category = create(:category)
    item = create(:item, categories: [category])

    visit item_path(item)

    expect(page).to have_text(item.title)
    expect(page).to have_text(item.description)
  end
end