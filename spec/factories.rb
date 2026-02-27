require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    password { '123456' }
  end

  factory :category do
    name { 'Fitness' }
  end

  factory :activity do
    association :category
    association :owner, factory: :user

    name { 'Morning Walk' }
    address { 'Berlin' }
    date_time { 2.days.from_now }
    description { 'Group walk in the park' }
    difficulty { 2 }
    equipment { 'Comfortable shoes' }
    max_count { 10 }
  end

  factory :chatroom do
    association :activity
  end
end
