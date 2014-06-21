Given(/^there is a User with admin permissions$/) do
  @user = create(:admin)
end

When(/^I visit users page$/) do
  visit(users_path)
end

Then(/^I should see at least one user$/) do
  expect(page).to have_content @user.email
  expect(page).to have_content @user.first_name
  expect(page).to have_content @user.last_name
end

And(/^there is a User with first name "(.*?)" and last name "(.*?)"$/) do |first_name, last_name|
  @lookup_user = create(:user, first_name: first_name, last_name: last_name)
end

When(/^I visit user page$/) do
  visit(user_path(@lookup_user))
end

When(/^I visit user edit page$/) do
  visit(edit_user_path(@lookup_user))
end

And(/^I should see user page with user "(.*?)"$/) do |user_full_name|
  split_name = user_full_name.split(' ')
  user = User.find_by first_name: split_name[0], last_name: split_name[1]
  expect(page).to have_content(user_full_name)
  expect(page).to have_content(user.full_name)
  expect(page).to have_content(user.email)
end

Given(/^I am on the users page$/) do
  visit(users_path)
end

Then(/^I should be on the new user page$/) do
  expect(current_path).to eq new_user_path
end

Then(/^I should be on the users page$/) do
  expect(current_path).to eq users_path
end

Given(/^I am on the new user page$/) do
  visit(new_user_path)
end

When(/^I click on "(.*?)" in "(.*?)" row$/) do |link, full_name|
  find(:xpath, "//tr[td[contains(.,'#{full_name}')]]/td/a", :text => link).click
end

And(/^there should not be User with name "(.*?)"$/) do |user_full_name|
  split_name = user_full_name.split(' ')
  user = User.find_by first_name: split_name[0], last_name: split_name[1]
  expect(user).to be_nil
  expect(page).to_not have_content(user_full_name)
end