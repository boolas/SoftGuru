require 'faker'

FactoryGirl.define do
  factory :project do
    association :user
    name 'First Project'
    description { Faker::Lorem.paragraph }
    language 'C#'

    factory :invalid_project do
      name nil
    end
  end
end