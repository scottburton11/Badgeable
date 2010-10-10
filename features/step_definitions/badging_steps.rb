Given /^a Meal awards the "([^\"]*)" badge to an? Diner after (\d+) times$/ do |badge_name, threshold|
  Meal.class_eval %Q{
    badge "#{badge_name}" do
      count #{threshold}
      subject :diner
      thing Meal
    end
  }
end

When /^a diner creates (\d+) meals$/ do |num|
  @diner = Diner.create
  num.to_i.times do
    @diner.meals.create
  end
end

Then /^the diner should have the "([^\"]*)" badge$/ do |badge_name|
  @diner.should have_badge_named(badge_name)
end
