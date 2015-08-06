Feature: Loggin In
  As a user
  I want to be able to log in and out of the system

  Background:
    Given an initial setup

  Scenario: Logging in is successful
    When I go to the login page
    And I fill in "username" with "egan"
    And I fill in "password" with "secret"
    And I press "Log In"
    Then I should see "Successfully signed in."
    And I should see "egan"
    And I should see "egan@example.com"
    And I should see "Playstation 4"
    And I should see "TheHype"
    And I should see "No reviews yet"
    And I should see "Edit"
    And I should see "egan" within ".nav-wrapper"
    And I should see "Log out" within ".nav-wrapper"

  Scenario: Unsuccessful login gives appropriate message
    When I go to the login page
    And I fill in "username" with "egan"
    And I fill in "password" with "password"
    And I press "Log In"
    Then I should see "Invalid username or password."
    And I should not see "egan" within ".nav-wrapper"
    And I should see "Log in" within ".nav-wrapper"
    And I should see "Sign Up" within ".nav-wrapper"

  Scenario: Appropriate message on log out
    Given a logged-in user
    When I go to log out
    Then I should see "Goodbye"
    And I should see "Log in" within ".nav-wrapper"
    And I should see "Sign Up" within ".nav-wrapper"

  Scenario: Updating user should fail with invalid input
    Given a logged-in user
    When I go to edit Egan's record
    Then I should see "Edit your Information"
    And I fill in "user_email" with "invalid email"
    And I press "Update User"
    Then I should see "is not a valid format"

  Scenario: Updating user should be successful with proper information
    Given a logged-in user
    When I go to edit Egan's record
    And I fill in "user_email" with "alex@example.com"
    And I press "Update User"
    Then I should see "Successfully updated your account."
    And I should see "TheHype"
    And I should see "alex@example.com"
    And I should not see "egan@example.com"
