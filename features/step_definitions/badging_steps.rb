Given /^a Meal awards the "([^\"]*)" badge to an? Diner after (\d+) times$/ do |badge_name, threshold|
  Meal.class_eval %Q{
    badge "#{badge_name}" do
      count #{threshold}
      subject :diner
      thing Meal
    end
  }
end

Given /^a User gets the "([^\"]*)" badge when their profile has been completed$/ do |badge_name|
  User.class_eval %Q{
    badge "#{badge_name}", :after => :save do
      thing User
      subject :user
      conditions do |user|
        user.profile_completeness == 100
      end
    end
  }
end

Given /^a User gets the "([^\"]*)" badge when they have written (\d+) reviews$/ do |badge_name, threshold|
  User.class_eval %Q{
    badge "#{badge_name}" do
      thing Review
      count #{threshold}
    end    
  }
end

When /^a diner creates (\d+) meals$/ do |num|
  @diner = Diner.create
  num.to_i.times do
    @diner.meals.create
  end
end

When /^the user has completed their profile$/ do
  @user = User.create
  @user.profile_completeness = 100
  @user.save
end

When /^the user has written (\d+) reviews$/ do |num|
  @user = User.create
  num.to_i.times do
    @user.reviews.create
  end
end

Then /^the diner should have the "([^\"]*)" badge$/ do |badge_name|
  @diner.should have_badge_named(badge_name)
end

Then /^the user should have the "([^\"]*)" badge$/ do |badge_name|
  @user.should have_badge_named(badge_name)
end
