Feature: Loggin In
  As a user
  I want to be able to see teams and players

  Background:
    Given a setup of teams and players

  Scenario: Viewing all teams
    When I go to the teams page
    Then I should see "All Teams"
    And I should see "Philadelphia Flyers"
    And I should see "2"
    And I should see "New York Rangers"
    And I should see "1"

  Scenario: Viewing one team
    When I go to the Flyers page
    Then I should see "Philadelphia Flyers"
    And I should see "Claude Giroux"
    And I should see "C"
    And I should see "90"
    And I should see "PLY"
    And I should see "Jakub Voracek"
    And I should see "87"
    And I should see "LW"

  Scenario: A Team name is a link to the Team page
    When I go to the teams page
    Then I should see "All Teams"
    And I click on the link "Philadelphia Flyers"
    And I should see "Claude Giroux"
    And I should see "Jakub Voracek"

  Scenario: Viewing a players page
    When I go to Giroux's page
    Then I should see "Claude Giroux"
    And I should see "Philadelphia Flyers"
    And I should see "Position"
    And I should see "C"
    And I should see "Overall Rating"
    And I should see "90"
    And I should see "Style"
    And I should see "PLY"

  Scenario: A player's name is a link to the player's page
    When I go to the Flyers page
    Then I should see "Philadelphia Flyers"
    And I click on the link "Claude Giroux"
    And I should see "Position"
    And I should see "C"
    And I should see "Overall Rating"
    And I should see "90"

  Scenario: A Team's name is a link to the Team's page
    When I go to Giroux's page
    And I click on the link "Philadelphia Flyers"
    And I should see "Players"
    And I should see "Jakub Voracek"
    And I should see "LW"
