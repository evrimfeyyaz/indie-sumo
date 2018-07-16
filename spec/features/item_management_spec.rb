require 'rails_helper'

feature 'Item management' do
  let(:category) { create(:category) }
  let(:item) { create(:item, categories: [category]) }

  scenario 'User visits an item details page' do
    visit item_path(item)

    expect(page).to have_text(item.title)
    expect(page).to have_text(item.description)
  end
end