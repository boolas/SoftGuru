require 'faker'

FactoryGirl.define do
  factory :project do
    association :user
    name { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    language 'C#'

    factory :invalid_project do
      name nil
    end
  end
end