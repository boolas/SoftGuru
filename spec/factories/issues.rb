# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :issue do
    association :user
    association :owner, factory: :admin
    association :project
    name { Faker::Name.title }
    description { Faker::Lorem.paragraph }
    issue_type "Bug"
    status "Open"

    factory :invalid_issue do
      name nil
    end

    factory :bug_started do
      issue_type "Bug"
      status "Started"
    end

    factory :bug_finished do
      issue_type "Bug"
      status "Finished"
    end

    factory :task_init do
      issue_type "Task"
      status "Open"
    end

    factory :task_started do
      issue_type "Task"
      status "Started"
    end

    factory :task_finished do
      issue_type "Task"
      status "Finished"
    end

    factory :feature_init do
      issue_type "Feature"
      status "Open"
    end

    factory :feature_started do
      issue_type "Feature"
      status "Started"
    end

    factory :feature_finished do
      issue_type "Feature"
      status "Finished"
    end

  end
end
