FactoryBot.define do
  factory :list do
    sequence(:title) { |n| "List #{n}" }
    association :resource, factory: :resource
  end
end
