class Meal
  include Mongoid::Document
  extend Badgeable::Award
  referenced_in :diner, :inverse_of => :meals
end