FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category #{n}" }

    trait :with_resource do
      after :create do |category|
        category.resources << create(:resource)
      end
    end
  end
end
