require 'rails_helper'

feature 'Resource management' do
  let(:category) { create(:category) }
  let!(:resource) { create(:resource, categories: [category]) }

  scenario 'User visits a resource details page' do
    visit resource_path(resource)

    within('#resource') do
      expect(page).to have_text(resource.title)
      expect(page).to have_text(resource.description)
      expect(page).to have_link(category.title)
    end
  end

  context 'User visits a resource details page with a list' do
    let(:list) { create(:list, resource: resource) }

    scenario 'and views the resources in the list' do
      resource_z = create(:resource, title: 'Zebra')
      create(:list_item, listable: resource_z, list: list)
      external_resource_a = create(:external_resource, title: 'Asphalt')
      create(:list_item, listable: external_resource_a, list: list)

      visit resource_path(resource)

      expect(page).to have_text(list.title)
      expect(page).to have_text(resource_z.title)
      expect(page).to have_text(resource_z.description)

      # Make sure they are sorted by title.
      expect(page).to have_css("#list-#{list.id}",
                               text:    /#{Regexp.escape(external_resource_a.title)}.+#{Regexp.escape(resource_z.title)}/,
                               visible: false)
    end

    scenario 'and views an item that is an external resource with link' do
      external_resource = create(:external_resource)
      create(:list_item, listable: external_resource, list: list)

      visit resource_path(resource)

      expect(page).to have_link(external_resource.title, href: external_resource.url)
    end

    scenario 'and views an item that is an external resource without a link' do
      external_resource = create(:external_resource, url: nil)
      create(:list_item, listable: external_resource, list: list)

      visit resource_path(resource)

      expect(page).to have_text(external_resource.title)
      expect(page).not_to have_link(external_resource.title)
    end
  end
end