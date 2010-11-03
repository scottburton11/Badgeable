Feature: Badges are marked as unseen until a user sees that they've won them
  So that I know which badges I've been awarded
  As a user who just had badges awarded
  I want to see my unseen badges, and once I've seen them, they should go away

  Scenario: Unseen badges
    Given I have 3 badges already
    And I have just been awarded 2 badges
    When I should have 2 unseen badges
  
  Scenario: Mark badges as seen
    Given I have 0 badges
    And I have just been awarded 2 badges
    When my unseen badges are marked as seen
    Then I should have 0 unseen badges
  
  
  