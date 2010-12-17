Feature: Easily award badges to any Ruby class (given enough effort on your part)
  In order to make somebody feel super awesome about themselves
  A class that extends Badgeable::Award
  Wants to award a badge recipient after they've created a certain number of them
  
  Scenario: A restaurant meal awards the "Hog Wild" badge to a regular diner
    Given a Meal awards the "Hog Wild" badge to an Diner after 3 times
    When a diner creates 3 meals
    Then the diner should have the "Hog Wild" badge

  Scenario: A user gets a badge when they've completed their profile
    Given a User gets the "Profile Complete" badge when their profile has been completed
    When the user has completed their profile
    Then the user should have the "Profile Complete" badge
  
  Scenario: A user gets a badge when he's written 10 reviews
    Given a User gets the "Guppy" badge when they have written 10 reviews
    When the user has written 10 reviews
    Then the user should have the "Guppy" badge
  
  Scenario: If I supply some extra attributes, the badge gets created with them
    Given A user gets the "Awesome" badge with a custom description "This badge is awesome" and icon "awesome-badge.jpg" for being awesome
    When they are awesome
    Then the user should have the "Awesome" badge
    And the badge description should be "This badge is awesome"
    And the badge icon should be "awesome-badge.jpg"
  
  
  