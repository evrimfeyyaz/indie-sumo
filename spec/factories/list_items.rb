FactoryBot.define do
  factory :list_item do
    association :list, factory: :list
  end
end
