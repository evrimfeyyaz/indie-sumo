FactoryBot.define do
  factory :resource do
    sequence(:title) { |n| "Resource #{n}" }
    description 'Lorem ipsum dolor sit amet.'

    trait :with_list do
      after :create do |resource|
        create(:list, :with_item, resource: resource)
      end
    end

    trait :with_comment do
      after :create do |resource|
        create(:comment, resource: resource)
      end
    end

    trait :with_category do
      after :create do |resource|
        create(:category, resources: [resource])
      end
    end

    trait :with_list do
      after :create do |resource|
        create(:list, :with_item, resource: resource)
      end
    end
  end
end
