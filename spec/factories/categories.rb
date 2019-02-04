FactoryBot.define do
  factory :category do
    sequence(:title) { |n| "Category #{n}" }
    coming_soon { false }

    trait :with_resource do
      after :create do |category|
        category.resources << create(:resource)
      end
    end

    trait :coming_soon do
      coming_soon { true }
    end
  end
end
