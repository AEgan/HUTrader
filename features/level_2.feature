Feature: Manage customers
  As a guest
  I want to be able to create a user account

  Background:
    Given an initial setup

  Scenario: Creating an account fails if not enough information is provided
    When I go to the new user page
    Then I should see "Create your Account"
    And I fill in "user_username" with "test"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    And I fill in "user_team_name" with "rhc"
    And I fill in "user_email" with "not an email address"
    And I select "Xbox One" from "user_console"
    And I press "Create User"
    Then I should see "is not a valid format"
    And I should see "Log in"

  Scenario: Creating an account is successful when validations pass
    When I go to the new user page
    Then I should see "Create your Account"
    And I fill in "user_username" with "test"
    And I fill in "user_password" with "secret"
    And I fill in "user_password_confirmation" with "secret"
    And I fill in "user_team_name" with "rhc"
    And I fill in "user_email" with "test@example.com"
    And I select "Xbox One" from "user_console"
    And I press "Create User"
    Then I should see "Welcome to HUTrader, test!"
    And I should not see "Log in"
    And I should not see "Sign Up"
    And I should see "Log out"
    And I should see "Xbox One"
    And I should see "No trades yet"
    And I should see "Edit"

  Scenario: Should View information of a user when not logged in
    When I go to Egan's details page
    Then I should see "egan"
    And I should see "Playstation 4"
    And I should see "egan@example.com"
    And I should see "TheHype"
    And I should not see "Edit"
