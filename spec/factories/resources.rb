FactoryBot.define do
  factory :resource do
    sequence(:title) { |n| "Resource #{n}" }
    description { 'Lorem ipsum dolor sit amet.' }
    category

    trait :with_comment do
      after :create do |resource|
        create(:comment, resource: resource)
      end
    end
  end
end
