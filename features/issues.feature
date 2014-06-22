Feature: Issues management
  Background: Authentication and visiting project issues
    Given there is a User
    And there is a Project with name "Test project"
    And I have authenticated my access
    Given there is an Issue associated with "Test project" and with name "Test bug"
    When I visit projects page
    And I click on "Issues" in "Test project" row
    Then I should be on the issues for project page
    And I should see "Test bug"

  Scenario: See details of issue
    When I visit issue page
    Then I should be on the issue page
    And I should see "Test bug"

  Scenario: Edit issue
    When I visit issue edit page
    Then I fill in "Name" with "Edited issue"
    And I press "Update Issue"
    Then I should see "Issue was successfully updated."
    And I should see issue page with issue "Edited issue"

  Scenario: New issue page
    When I click on "New Issue"
    Then I should be on the new issue page
    When I click on "Back"
    Then I should be on the issues for project page

  Scenario: Create a new issue
    Given I am on the new issue page
    When I fill in "Name" with "Test issue create"
    And I fill in "Description" with "Test description"
    And I press "Create Issue"
    Then I should see "Issue was successfully created."
    And I should see issue page with issue "Test issue create"