Given(/^there is a User$/) do
  FactoryGirl.create(:user)
end

And(/^the User has posted the project "(.*?)"$/) do |project_name|
  expect(User.count).to eq 1
  FactoryGirl.create(:project, :name => project_name, :user => User.first)
end

When(/^I visit main page$/) do
  visit(root_path)
end

Then(/^I should see "(.*?)"$/) do |project_name|
  page.should have_content(project_name)
end