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
  Given %Q{I am a user}
  @user.profile_completeness = 100
  @user.save
end

When /^the user has written (\d+) reviews$/ do |num|
  Given %Q{I am a user}
  num.to_i.times do
    @user.reviews.create
  end
end

Given /^I am a user$/ do
  @user = User.create
end

Then /^the diner should have the "([^\"]*)" badge$/ do |badge_name|
  @diner.should have_badge_named(badge_name)
end

Then /^the user should have the "([^\"]*)" badge$/ do |badge_name|
  @user.should have_badge_named(badge_name)
end

Given /^I have (\d+) badges already$/ do |num|
  Given %Q{I am a user}
  num.to_i.times do |n|
    badging = @user.award_badge("Badge #{n}")
    badging.update_attributes(:seen => true)
  end
end

Given /^I have just been awarded (\d+) badges$/ do |num|
  Given %Q{I am a user}
  num.to_i.times do |n|
    @user.award_badge("Unseen Badge #{n}")
  end
end

Then /^I should have (\d+) unseen badges$/ do |num|
  @user.badgings.unseen.count.should eql(num.to_i)
end

Given /^I have (\d+) badges$/ do |num|
  Given %Q{I have #{num} badges already}
end

When /^my unseen badges are marked as seen$/ do
  @user.badgings.each do |badging|
    badging.mark_as_seen
  end
end
