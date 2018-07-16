require 'rails_helper'

feature 'Resource management' do
  let(:category) { create(:category) }
  let(:resource) { create(:resource, categories: [category]) }

  scenario 'User visits a resource details page' do
    visit resource_path(resource)

    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.description)
  end

  context 'User visits a resource details page with a list' do
    let(:list) { create(:list, resource: resource) }

    scenario 'and clicks on an item that is an external link' do
      item = create(:external_resource, list: list)

      visit resource_path(resource)

      expect(page).to have_text(list.title)
      expect(page).to have_link(item.title, href: item.url)
      expect(page).to have_text(item.description)
    end
  end
end