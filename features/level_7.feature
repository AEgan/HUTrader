Feature: Trading
  As a user
  I want to be able to see comments on offers

  Background:
    Given a full setup

  Scenario: Not seeing any comments
    When I go to Matt's offer page
    Then I should see "Comments"
    And I should see "This offer has no comments."

  Scenario: Seeing all of the comments
    When I go to Mike's offer page
    Then I should see "Comments"
    And I should see "egan"
    And I should see "mike"
    And I should see "Sounds like a great trade!"

  Scenario: Can't click on link if not right user
    Given a logged-in xbox user
    When I go to Mike's offer page
    Then I should see "Comments"
    And I should see "egan"
    And I should see "mike"
    And I should not see "New Comment"

  Scenario: New Comment is a link to the new comment page
    Given a logged-in user
    When I go to Mike's offer page
    Then I should see "Comments"
    And I should see "New Comment"
    And I click on the link "New Comment"
    Then I should see "Body"

  Scenario: Posting a new comment is successful
    Given a logged-in user
    When I go to Mike's offer page
    And I click on the link "New Comment"
    Then I should see "New Comment"
    And I fill in "comment_body" with "Let's trade!"
    And I press "Create Comment"
    Then I should see "Comment successfully posted."
    And I should see "egan"
    And I should see "mike's Offer"
    And I should see "Players"
    And I should see "Let's trade!"

  Scenario: No edit link if not logged in
    Given a logged-in xbox user
    When I go to Mike's offer page
    Then I should see "Comments"
    And I should see "egan"
    And I should see "mike"
    And I should not see "edit"

  Scenario: Edit link available shown for own comments
    Given a logged-in user
    When I go to Mike's offer page
    Then I should see "Comments"
    And I should see "edit"
    And I click on the link "edit"
    Then I should see "Edit Comment"

  Scenario: Users can edit a comment
    Given a logged-in user
    When I go to Mike's offer page
    And I click on the link "edit"
    And I fill in "comment_body" with "I am updating this comment."
    And I press "Update Comment"
    Then I should see "mike's Offer"
    And I should see "Comments"
    And I should see "egan"
    And I should see "I am updating this comment."
    And I should not see "Sounds like a great trade!"
    And I should see "Comment successfully updated."

  Scenario: username is link to user page
    Given a logged-in user
    When I go to Mike's offer page
    And I click on the link "mike"
    Then I should see "mike"
    And I should see "Playstation 4"
