Feature: Trading
  As a user
  I want to be able to see offers for trades

  Background:
    Given a full setup

  Scenario: Viewing Trade offers
    When I go to Alex's Giroux trade page
    Then I should see "Offers" within "#offers-detail-area"
    And I should see "mike"
    And I should see "5000"
    And I should see "Voracek"
    And I should see "Tavares"
    And I should see "Mcdonagh"
    And I should see "Giroux"

  Scenario: Can't accept offer if not logged in
    When I go to Alex's Giroux trade page
    Then I should see "Offers" within "#offers-detail-area"
    And I should see "This trade is open to offers."
    And I should not see "Accept Offer"

  Scenario: Can accept offer if logged in
    Given a logged-in user
    When I go to Alex's Giroux trade page
    Then I should see "Offers" within "#offers-detail-area"
    And I should see "This trade is open to offers."
    And I should see "Accept Offer"
    And I click on the link "Accept Offer"
    And I should see "You have accepted this offer."
    And I should see "egan has selected mike's offer."

  Scenario: Can see a single offer's details
    When I go to Mike's offer page
    Then I should see "mike's Offer"
    And I should see "Coins: 5000"
    And I should see "Players"
    And I should see "John Tavares"
    And I should see "Jakub Voracek"
    And I should see "Ryan Mcdonagh"
    And I should see "90"
    And I should see "89"
    And I should see "87"
    And I should not see "Edit Trade"
    And I should not see "Accept Offer"

  Scenario: Can accept an offer from the details page
    Given a logged-in user
    When I go to Mike's offer page
    Then I should see "mike's Offer"
    And I should not see "Edit Trade"
    And I should see "Accept Offer"
    And I click on the link "Accept Offer"
    And I should see "You have accepted this offer."
    And I should see "egan has selected mike's offer."

  Scenario: Can create a trade offer
    Given a logged-in xbox user
    When I go to John's Tavares trade page
    Then I click on the link "Offer Trade"
    And I fill in "offer_coins" with "5000"
    And I select "Voracek, Jakub" from "offer_offer_players_attributes_0_player_id"
    And I press "Create Offer"
    Then I should see "Your offer has been posted."

  Scenario: Can't see offer trade button if different console
    Given a logged-in xbox user
    When I go to Alex's Giroux trade page
    Then I should see "This trade is for Playstation 4"
    And I should not see "Offer Trade"

  @javascript
  Scenario: Adding a second player to a trade
    Given a logged-in xbox user
    When I go to John's Tavares trade page
    Then I click on the link "Offer Trade"
    And I fill in "offer_coins" with "5000"
    And I select "Voracek, Jakub" from "offer_offer_players_attributes_0_player_id"
    And I press "Create Offer"
    And I should see "Edit Offer"
    And I click on the link "Edit Offer"
    Then I should see "Edit Your Offer"
    And I should see "Add Player"
    And I click on the link "Add Player"
    And I select "Mcdonagh, Ryan" from the nested form
    Then I press "Update Offer"
    Then I should see "Your offer has been updated."
    And I should see "Ryan Mcdonagh"

  @javascript
  Scenario: Removing a player from a trade offer
    Given a logged-in xbox user
    When I go to John's Tavares trade page
    Then I click on the link "Offer Trade"
    And I fill in "offer_coins" with "5000"
    And I select "Voracek, Jakub" from "offer_offer_players_attributes_0_player_id"
    And I press "Create Offer"
    Then I should see "Jakub Voracek"
    And I click on the link "Edit Offer"
    And I click on the link "x"
    And I press "Update Offer"
    Then I should see "Your offer has been updated."
    And I should not see "Jakub Voracek"
