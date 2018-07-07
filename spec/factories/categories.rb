FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category #{n}" }
    description 'Lorem ipsum dolor sit amet'
  end
end
