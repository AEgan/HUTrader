Feature: Standard Business
  As a user
  I want to be able to view certain information
  So I can have confidence in the system

  Background:

  Scenario: Do not see the default rails page
    When I go to the home page
    Then I should not see "You're riding Ruby on Rails!"
    And I should not see "About your application's environment"
    And I should not see "Create your database"

  Scenario: See information on the home page
    When I go to the home page
    Then I should see "Welcome to HUTrader"
    And I should see "Upcoming Features:"
    And I should see "See here for more information on HUT" within "#footer"
    And I should see "Log in" within ".nav-wrapper"
    And I should not see "egan" within ".nav-wrapper"
    And I should not see "Log out" within ".nav-wrapper"
