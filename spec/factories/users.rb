FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "#{n}@example.com" }
    password { '123456' }
  end
end
