FactoryBot.define do
  factory :list_item do
    association :list
    association :listable, factory: :resource
  end
end