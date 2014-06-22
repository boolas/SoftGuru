Feature: Admin issues management
  Background: User authentication and project
    Given there is a User with admin permissions
    And there is a Project with name "Test project"
    And I have authenticated my access

  Scenario: View all issues as admin
    Given there is an Issue with name "Test bug"
    When I visit all issues page
    Then I should see "Test bug"

  @javascript
  Scenario: Delete issue
    Given there is an Issue associated with "Test project" and with name "Test bug"
    When I visit projects page
    And I click on "Issues" in "Test project" row
    Then I should be on the issues for project page
    And I should see "Test bug"
    When I click on "Destroy" in "Test bug" row
    And I confirm alert message
    Then I should be on the issues for project page
    And there should not be Issue with name "Test bug"