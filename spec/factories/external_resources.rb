FactoryBot.define do
  factory :external_resource do
    sequence(:title) { |n| "External Resource #{n}" }
    url { 'https://www.example.com' }
  end
end
