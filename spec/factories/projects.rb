FactoryGirl.define do
  factory :project do
    association :user
    name 'First Project'
    description { Faker::Lorem.paragraph }
    language 'C#'
  end
end