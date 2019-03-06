require 'rails_helper'

describe 'Resource management' do
  let(:category) { create(:category) }
  let(:related_resource) { create(:resource) }
  let!(:resource) { create(:resource, category: category, related_resources: [related_resource]) }
  let!(:referencing_resource) { create(:resource, related_resources: [resource]) }

  scenario 'User visits a resource details page' do
    visit resource_path(resource)

    within('#resource') do
      expect(page).to have_text(resource.title)
      expect(page).to have_text(resource.description)
      expect(page).to have_link(category.title)
    end

    within('#resource-associated') do
      expect(page).to have_text(related_resource.title)
      expect(page).to have_text(referencing_resource.title)
    end
  end
end