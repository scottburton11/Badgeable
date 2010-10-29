class User
  include Mongoid::Document
  include Badgeable::Subject
  extend Badgeable::Award
  field :profile_completeness, :type => Integer
  references_many :reviews
end