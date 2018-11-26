FactoryBot.define do
  factory :information_recommendation do
    recommender_name { 'John Doe' }
    recommender_email { 'johndoe@example.com' }
    information { 'Lorem ipsum dolor sit amet.' }
  end
end
