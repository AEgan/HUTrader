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

  Scenario: Creating a trade is unsuccessful if not logged in
    When I go to the new trade page
    Then I should not see "Create a new trade"
    And I should not see "Create a trade for Xbox One"
    And I should not see "Create a trade for Playstation 4"
    And I should see "You are not authorized to perform this action."

  Scenario: The new trade page says the console name for Playstation
    Given a logged-in user
    When I go to the new trade page
    Then I should see "Create a trade for Playstation 4"
    And I should not see "Create a trade for Xbox One"

  Scenario: The new trade page says the console name for Xbox
    Given a logged-in xbox user
    When I go to the new trade page
    Then I should see "Create a trade for Xbox One"
    And I should not see "Create a trade for Playstation 4"

  Scenario: Trying to create a trade is unsuccessful without choosing a player
    Given a logged-in user
    When I go to the new trade page
    And I press "Create Trade"
    Then I should see "Please review the problems below"
    And I should see "does not exist in the system"
    And I should not see "Trade for"
    And I should not see "has been posted."

  Scenario: Creating a trade with a real player is successful
    Given a logged-in user
    When I go to the new trade page
    And I select "Giroux, Claude" from "trade_player_id"
    And I press "Create Trade"
    Then I should see "Trade Details"
    And I should see "Trade for Claude Giroux has been posted."

  Scenario: Viewing all trade information
    When I go to Alex's Giroux trade page
    Then I should see "This trade is for Playstation 4"
    And I should see "Claude Giroux"
    And I should see "egan"
    And I should see "TheHype"
    And I should see "This trade is open to offers."

  Scenario: The page says the status and the console for the trade
    Given a setup of offers
    When I go to Matt's McDonagh trade page
    Then I should see "This trade is for Xbox One"
    And I should see "matt and egan have completed the trade."

  Scenario: The user name is a link to the user's page
    When I go to Alex's Giroux trade page
    And I click on the link "egan"
    Then I should see "egan"
    And I should see "TheHype"
    And I should see "egan@example.com"

  Scenario: The players name is a link to the Player's page
    When I go to Alex's Giroux trade page
    And I click on the link "Claude Giroux"
    Then I should see "Philadelphia Flyers"
    And I should see "90"

  Scenario: Should not see the cancel button if not logged in
    When I go to Alex's Giroux trade page
    Then I should not see "Cancel this trade"

  Scenario: Should not see the cancel button if not logged in as correct user
    Given a logged-in user
    When I go to Alex's Giroux trade page
    Then I should see "Cancel this trade"

  Scenario: Should not see cancel button if logged in with different user
    Given a logged-in xbox user
    When I go to Alex's Giroux trade page
    Then I should not see "Cancel this trade"

  Scenario: The cancel button should close the trade
    Given a logged-in user
    When I go to Alex's Giroux trade page
    Then I should see "Cancel this trade"
    And I click on the link "Cancel this trade"
    Then I should see "Trade has been closed."
    And I should see "This trade has been cancelled by egan."
