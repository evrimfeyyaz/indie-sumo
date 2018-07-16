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

    scenario 'and clicks on an item that is an external resource with link' do
      external_resource = create(:external_resource)
      create(:list_item, listable: external_resource, list: list)

      visit resource_path(resource)

      expect(page).to have_text(list.title)
      expect(page).to have_link(external_resource.title, href: external_resource.url)
      expect(page).to have_text(external_resource.description)
    end

    scenario 'and clicks on an item that is an external resource without a link' do
      external_resource = create(:external_resource, url: nil)
      create(:list_item, listable: external_resource, list: list)

      visit resource_path(resource)

      expect(page).to have_text(list.title)
      expect(page).to have_text(external_resource.title)
      expect(page).to have_text(external_resource.description)
      expect(page).not_to have_link(external_resource.title)
    end
  end
end