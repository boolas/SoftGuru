Feature: See Projects
  Scenario: See list of projects
    Given there is a User
    And the User has posted the project "First Project"
    When I visit main page
    Then I should see "First Project"