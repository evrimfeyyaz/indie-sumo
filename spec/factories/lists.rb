FactoryBot.define do
  factory :list do
    sequence(:title) { |n| "List #{n}" }
    association :resource

    trait :with_item do
      after :create do |list|
        create(:list_item, list: list)
      end
    end
  end
end
