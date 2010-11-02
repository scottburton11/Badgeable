module Badgeable
  module Adapters
    module MongoidAdapter
      def self.included(receiver)
        receiver.class_eval %Q{ 
          references_many :badges, :stored_as => :array, :class_name => "Badge", :inverse_of => :#{receiver.to_s.tableize}
        }
        
        Badge.class_eval %Q{
          references_many :#{receiver.to_s.tableize}, :inverse_of => :badges, :stored_as => :array
        
          def recipients
            #{receiver}.where(:badge_ids => id)
          end
        }
      end
    end
  end
end

class Badge
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :name
  index :name
  
  def self.find_or_create_by_name(name)
    criteria.where(:name => name).first || create(:name => name)
  end
  
  def icon
    "/images/#{name}"
  end
end
