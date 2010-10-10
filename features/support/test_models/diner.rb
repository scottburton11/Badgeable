class Diner
  include Mongoid::Document
  include Badgeable::Subject
  references_many :meals
end