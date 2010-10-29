class Review
  include Mongoid::Document
  extend Badgeable::Award
  referenced_in :user
end