Given(/^there is an Issue with name "(.*?)"$/) do |issue_name|
  @issue = create(:issue, name: issue_name)
end

Given(/^there is an Issue associated with "(.*?)" and with name "(.*?)"$/) do |project_name, issue_name|
  project = Project.find_by_name(project_name)
  @issue = create(:issue, name: issue_name, project_id: project.id)
end

When(/^I visit all issues page$/) do
  visit(issues_path)
end

Then(/^I should be on the issues for project page$/) do
  expect(current_path).to eq project_issues_path(@project)
end

When(/^I visit issue edit page$/) do
  visit(edit_project_issue_path(@project, @issue))
end

And(/^I should see issue page with issue "(.*?)"$/) do |issue_name|
  issue = Issue.find_by_name(issue_name)
  expect(page).to have_content(issue.name)
  expect(page).to have_content(issue.description)
  expect(page).to have_content(issue.issue_type)
  expect(page).to have_content(issue.status)
  expect(page).to have_content(issue.project.name)
  expect(page).to have_content(issue.user.full_name)
  expect(page).to have_content(issue.owner.full_name)
end

When(/^I visit issue page$/) do
  visit(project_issue_path(@project, @issue))
end

Then(/^I should be on the issue page$/) do
  expect(current_path).to eq project_issue_path(@project, @issue)
end

Then(/^I should be on the new issue page$/) do
  visit(new_project_issue_path(@project))
end

Given(/^I am on the new issue page$/) do
  visit(new_project_issue_path(@project))
end

And(/^there should not be Issue with name "(.*?)"$/) do |issue_name|
  issue = Issue.find_by_name(issue_name)
  expect(issue).to be_nil
  expect(page).to_not have_content(issue_name)
end