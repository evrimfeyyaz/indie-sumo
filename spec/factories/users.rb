FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user_#{n}" }
    sequence(:email) { |n| "#{username}@example.com" }
    password { '123456' }
    confirmed_at { Time.now }
  end
end
