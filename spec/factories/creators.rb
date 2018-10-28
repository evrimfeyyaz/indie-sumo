FactoryBot.define do
  factory :creator do
    name 'John Doe'
    url 'http://www.example.com'
    association :resource

    trait :with_referenced_resource do
      after :create do |creator|
        creator.referenced_resource = create(:resource)
        creator.save
      end
    end
  end
end