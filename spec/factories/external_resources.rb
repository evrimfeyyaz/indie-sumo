FactoryBot.define do
  factory :external_resource do
    sequence(:title) { |n| "External Resource #{n}" }
    description 'Lorem ipsum dolor sit amet.'
    url 'https://www.example.com'
  end
end
