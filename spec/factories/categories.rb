FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category #{n}" }
    description 'Lorem ipsum dolor sit amet'

    trait :with_resource do
      after :create do |category|
        create(:resource, categories: [category])
      end
    end
  end
end
