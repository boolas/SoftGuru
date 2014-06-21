Feature: Manage projects
  Scenario: See list of projects
    Given there is a User
    And the User has posted the project "First Project"
    When I visit main page
    Then I should see "First Project"

  Scenario: See details of project
    Given there is a Project with name "First Project"
    When I visit project page
    Then I should see "First Project"
    And I should see "C#"

  Scenario: Edit project
    Given there is a User
    Given there is a Project with name "First Project"
    And I have authenticated my access
    When I visit project edit page
    Then I fill in "Name" with "Edited Project"
    And I press "Update Project"
    Then I should see "Project was successfully updated."
    And I should see project page with project "Edited Project"

  Scenario: New project page
    Given there is a User
    And I have authenticated my access
    Given I am on the projects page
    When I click on "New Project"
    Then I should be on the new project page
    When I click on "Back"
    Then I should be on the projects page

  Scenario: Create a new project
    Given there is a User
    And I have authenticated my access
    Given I am on the new project page
    When I fill in "Name" with "Test project"
    And I fill in "Description" with "Test description"
    And I fill in "Language" with "Ruby"
    And I press "Create Project"
    Then I should see "Project was successfully created."
    And I should see project page with project "Test project"

#  @javascript
#  Scenario: Delete project
#    Given there is a User with admin permissions
#    And I have authenticated my access
#    Given there is a Project with name "Test project"
#    And I visit projects page
#    When I click on "Destroy" in "Test project" row
#    And I confirm alert message
#    Then I should be on the projects page
#    And there should not be Project with name "Test project"