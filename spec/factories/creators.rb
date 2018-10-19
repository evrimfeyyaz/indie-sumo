FactoryBot.define do
  factory :creator do
    name 'John Doe'
    url 'http://www.example.com'
    association :resource
  end
end