require 'faker'

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :admin do
      admin true
    end

    factory :invalid_user do
      last_name nil
    end
  end

  factory :owner do
    email { Faker::Internet.email }
    password 'secret'
    password_confirmation 'secret'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :admin_owner do
      admin true
    end

    factory :invalid_owner do
      last_name nil
    end
  end
end