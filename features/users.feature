Feature: Manage users
  Background: Admin and authentication
    Given there is a User with admin permissions
    And I have authenticated my access

  Scenario: See list of users
    When I visit users page
    Then I should see at least one user

  Scenario: See details of user
    Given there is a User with first name "John" and last name "Doe"
    When I visit user page
    Then I should see "John Doe"

  Scenario: Edit user
    Given there is a User with first name "John" and last name "Doe"
    When I visit user edit page
    Then I fill in "First name" with "James"
    And I press "Update User"
    Then I should see "User was successfully updated."
    And I should see user page with user "James Doe"

  Scenario: New user page
    Given I am on the users page
    When I click on "New User"
    Then I should be on the new user page
    When I click on "Back"
    Then I should be on the users page

  Scenario: Create a new user
    Given I am on the new user page
    When I fill in "Email" with "james@dean.gov"
    And I fill in "First name" with "James"
    And I fill in "Last name" with "Dean"
    And I fill in "Password" with "secret"
    And I fill in "Password confirmation" with "secret"
    And I press "Create User"
    Then I should see "User was successfully created."
    And I should see user page with user "James Dean"

#  @javascript
#  Scenario: Delete user
#    Given there is a User with first name "John" and last name "Doe"
#    And I visit users page
#    When I click on "Destroy" in "John Doe" row
#    And I confirm alert message
#    Then I should be on the users page
#    And there should not be User with name "John Doe"