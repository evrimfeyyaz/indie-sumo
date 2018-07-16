require 'rails_helper'

feature 'Resource management' do
  let(:category) { create(:category) }
  let(:resource) { create(:resource, categories: [category]) }

  scenario 'User visits a resource details page' do
    visit resource_path(resource)

    expect(page).to have_text(resource.title)
    expect(page).to have_text(resource.description)
  end
end