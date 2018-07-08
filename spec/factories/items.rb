FactoryBot.define do
  factory :item do
    sequence(:title) { |n| "Item #{n}" }
    description 'Lorem ipsum dolor sit amet.'
  end
end
