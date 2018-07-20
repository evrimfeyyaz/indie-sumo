require 'rails_helper'

feature 'Resource recommendation management' do
  let(:category) { create(:category, title: 'People') }

  scenario 'User visits a category page and recommends a person' do
    visit category_path(category)

    click_link('Recommend a Person', match: :first)

    expect(current_path).to eq(new_category_resource_recommendation_path(category))

    recommender_name = 'John Doe'
    recommender_email = 'john@example.com'
    name = 'Paul Graham'
    website = 'www.paulgraham.com'
    other_information = 'Lorem ipsum dolor sit amet.'

    fill_in 'Recommender name', with: recommender_name
    fill_in 'Recommender email', with: recommender_email
    fill_in 'Name', with: name
    fill_in 'Website', with: website
    fill_in 'Other information', with: other_information

    click_button 'Submit'

    result = ResourceRecommendation.last
    expect(result.recommender_name).to eq(recommender_name)
    expect(result.recommender_email).to eq(recommender_email)
    expect(result.name).to eq(name)
    expect(result.website).to eq(website)
    expect(result.other_information).to eq(other_information)
  end
end