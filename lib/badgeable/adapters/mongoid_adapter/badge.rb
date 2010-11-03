class Badge
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  index :name
  
  def self.find_or_create_by_name(name)
    criteria.where(:name => name).first || create(:name => name)
  end
  
  def icon
    "/images/#{name.parameterize}.jpg"
  end
end
