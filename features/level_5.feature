Feature: Trading
  As a user
  I want to be able to see available trades

  Background:
    Given a setup of trades

  Scenario: Viewing all open trades
    When I go to the trades page
    Then I should see "All"
    And I should see "Playstation"
    And I should see "Xbox"
    And I should see "Claude Giroux"
    And I should see "John Tavares"
    And I should not see "Jakub Voracek"
    And I should see "egan"
    And I should see "TheHype"
    And I should see "Xbox One"
    And I should see "Playstation 4"
    And I should not see "Add new Trade"
    And I should see "All" within ".active"

  Scenario: Trades split up by console
    When I go to the trades page
    Then I should see "Claude Giroux" within "#all-trades"
    And I should see "Claude Giroux" within "#playstation-trades"
    And I should not see "Claude Giroux" within "#xbox-trades"
    And I should see "John Tavares" within "#all-trades"
    And I should see "John Tavares" within "#xbox-trades"
    And I should not see "John Tavares" within "#playstation-trades"

  Scenario: logged in users can create a trade and have table set to their console
    Given a logged-in user
    When I go to the trades page
    Then I should see "egan" within ".nav-wrapper"
    And I should see "Add new Trade"
    And I should see "Playstation" within ".active"
    And I should not see "Xbox" within ".active"
    And I should not see "All" within ".active"

  Scenario: Clicking on the new trade button will go to the new trade page
    Given a logged-in user
    When I go to the trades page
    And I click on the link "Add new Trade"
    Then I should see "Create a new trade"

  Scenario: Clicking on the name of the player is a link to the trade page
    When I go to the trades page
    And I click on the first link "Claude Giroux"
    Then I should see "Trade Details"
