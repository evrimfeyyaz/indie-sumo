FactoryBot.define do
  factory :resource_recommendation do
    recommender_name { 'John Doe' }
    recommender_email { 'johndoe@example.com' }
    name { 'Paul Graham' }
    website { 'www.paulgraham.com' }
    other_information { 'Lorem ipsum dolor sit amet.' }
  end
end
