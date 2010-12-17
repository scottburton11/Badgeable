class Badge
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  field :description
  field :icon
  index :name
  
  before_create :assign_default_icon_name, :unless => lambda{icon}
  
  def self.find_or_create_by_name(name, options)
    attrs = options.merge(:name => name)
    criteria.where(:name => name).first || create(attrs)
  end
  
  private
  
  def assign_default_icon_name
    self.icon = default_icon_name
  end
  
  def default_icon_name
    "#{name.parameterize}.png"
  end
  
end
