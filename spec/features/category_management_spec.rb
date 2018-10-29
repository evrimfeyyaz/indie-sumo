require 'rails_helper'

feature 'Category management' do
  let(:category) { create(:category) }

  scenario 'User visits the home page' do
    category_z = create(:category, title: 'Zebra')
    category_a = create(:category, title: 'Asphalt')

    visit root_path

    expect(page).to have_text(category_a.title)
    expect(page).to have_text(category_a.description)

    # Make sure they are sorted by title.
    expect(page).to have_css('#categories',
                             text:    /#{Regexp.escape(category_a.title)}.+#{Regexp.escape(category_z.title)}/,
                             visible: false)
  end

  scenario 'User clicks on a category on the home page, and visits the category details page' do
    resource_z = create(:resource, title: 'Zebra', categories: [category])
    resource_a = create(:resource, title: 'Asphalt', categories: [category])

    visit root_path

    click_link(category.title, match: :first)

    expect(page).to have_current_path(category_path(category))
    expect(page).to have_text(category.title)
    expect(page).to have_text(category.description)

    expect(page).to have_text(resource_a.title)
    expect(page).to have_text(resource_a.description)

    # Make sure they are sorted by title.
    expect(page).to have_css('#resources',
                             text: /#{Regexp.escape(resource_a.title)}.+#{Regexp.escape(resource_z.title)}/,
                             visible: false)
  end

  scenario 'User clicks on a category that is not published' do
    coming_soon_category = create(:category,
                                  :coming_soon,
                                  :with_resource)
    resource = coming_soon_category.resources.first

    visit category_path(coming_soon_category)

    expect(page).to have_text('Coming Soon')
    expect(page).not_to have_text(resource.title)
  end

  scenario 'User clicks on a resource on the category details page, and visits the resource details page' do
    resource = create(:resource, categories: [category])

    visit category_path(category)

    click_link resource.title

    expect(page).to have_current_path(resource_path(resource))
  end
end