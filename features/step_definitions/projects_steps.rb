Given(/^there is a User$/) do
  @user = create(:user)
end

And(/^the User has posted the project "(.*?)"$/) do |project_name|
  expect(User.count).to eq 1
  create(:project, :name => project_name, :user => User.first)
end

When(/^I visit main page$/) do
  visit(root_path)
end

Then(/^I should see "(.*?)"$/) do |content|
  expect(page).to have_content(content)
end

Given(/^there is a Project with name "(.*?)"$/) do |project_name|
  @project = create(:project, :name => project_name)
end

When(/^I visit project page$/) do
  visit(project_path(@project))
end

Given(/^I am on the projects page$/) do
  visit(projects_path)
end

When(/^I click on "(.*?)"$/) do |link|
  click_on(link)

end

Then(/^I should be on the new project page$/) do
  expect(current_path).to eq new_project_path
end

Then(/^I should be on the projects page$/) do
  expect(current_path).to eq projects_path
end

Given(/^I am on the new project page$/) do
  visit(new_project_path)
end

When(/^I fill in "(.*?)" with "(.*?)"$/) do |field, value|
  fill_in field, with: value
end

And(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

And(/^I should see project page with project "(.*?)"$/) do |project_name|
  project = Project.find_by_name(project_name)
  expect(page).to have_content(project.name)
  expect(page).to have_content(project.description)
  expect(page).to have_content(project.language)
  expect(page).to have_content(project.user.full_name)
end

When(/^I visit project edit page$/) do
  visit(edit_project_path(@project))
end

When(/^I visit projects page$/) do
  visit(projects_path)
end

And(/^I confirm alert message$/) do
  page.driver.browser.switch_to.alert.accept
  #page.driver.browser.switch_to.alert.dismiss
end

And(/^there should not be Project with name "(.*?)"$/) do |project_name|
  project = Project.find_by_name(project_name)
  expect(project).to be_nil
  expect(page).to_not have_content(project_name)
end

And(/^I have authenticated my access$/) do
  steps %{
    When I visit login page
    And I fill in "Email" and "Password" with user data
    And I press "Log In"
    Then I should see notice "Logged in!"
  }
end

And(/^I visit login page$/) do
  visit(login_path)
end

And(/^I fill in "(.*?)" and "(.*?)" with user data$/) do |field1, field2|
  fill_in field1, with: @user.email
  fill_in field2, with: @user.password
end

And(/^I should see notice "(.*?)"$/) do |notice|
  expect(page).to have_content(notice)
end