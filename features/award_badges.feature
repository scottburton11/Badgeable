Feature: Easily award badges to any Ruby class (given enough effort on your part)
  In order to make somebody feel super awesome about themselves
  A class that extends Badgeable::Award
  Wants to award a badge recipient after they've created a certain number of them
  
  Scenario: A restaurant meal awards the "Hog Wild" badge to a regular diner
    Given a Meal awards the "Hog Wild" badge to an Diner after 3 times
    When a diner creates 3 meals
    Then the diner should have the "Hog Wild" badge
