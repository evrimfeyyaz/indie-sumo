require 'rails_helper'

feature 'Information recommendation management' do
  let(:resource) do
    category = create(:category)
    create(:resource, categories: [category])
  end

  scenario 'User visits a resource page and recommends new information' do
    visit resource_path(resource)

    click_link('Add Information', match: :first)

    expect(current_path).to eq(new_resource_information_recommendation_path(resource))

    recommender_name = 'John Doe'
    recommender_email = 'john@example.com'
    information = 'Lorem ipsum dolor sit amet.'

    fill_in 'Recommender name', with: recommender_name
    fill_in 'Recommender email', with: recommender_email
    fill_in 'Information', with: information

    click_button 'Submit'

    result = InformationRecommendation.last
    expect(result.recommender_name).to eq(recommender_name)
    expect(result.recommender_email).to eq(recommender_email)
    expect(result.information).to eq(information)
  end
end