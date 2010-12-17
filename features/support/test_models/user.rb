class User
  include Mongoid::Document
  include Badgeable::Subject
  extend Badgeable::Award
  field :profile_completeness, :type => Integer
  field :awesome, :type => Boolean, :default => false
  references_many :reviews
end