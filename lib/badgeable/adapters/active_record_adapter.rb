module Badgeable
  module Adapters
    module ActiveRecordAdapter
      extend ActiveSupport::Concern
      
      def self.included(receiver)
        receiver.class_eval %Q{ 
          has_many :badgings
          has_many :badges, :through => :badgings
        }
        
        Badging.class_eval %Q{
          belongs_to :#{receiver.to_s.underscore}
        }
        
        Badge.class_eval %Q{
          has_many :badgings
          has_many :#{receiver.to_s.tableize}, :through => :badgings
        }
      end
    end
  end
end


class Badging < ActiveRecord::Base
  belongs_to :badge
  scope :unseen, {:where => {:seen => false}}
  
  def mark_as_seen
    update_attributes(:seen => true)
  end
end  

class Badge < ActiveRecord::Base
  def self.find_or_create_by_name(name)
    Badge.where(:name => name).first || create(:name => name)
  end
  
  def icon
    "/images/#{name.parameterize}.jpg"
  end
end
