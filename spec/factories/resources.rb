FactoryBot.define do
  factory :resource do
    sequence(:title) { |n| "Resource #{n}" }
    description 'Lorem ipsum dolor sit amet.'
  end
end
