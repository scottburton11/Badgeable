module Badgeable
  module Subject
    # Award a named badge to this object. If the badge doesn't exist
    # in the database already, it's created by name.
    def award_badge(name)
      badge = Badgeable::Badge.find_or_create_by_name(name)
      badges << badge unless has_badge?(badge)      
    end
    
    def has_badge?(badge)
      badges.include?(badge)
    end
    
    def has_badge_named?(name)
      badges.map(&:name).include?(name)
    end
    
    def self.included(receiver)
      receiver.class_eval %Q{ 
        references_many :badges, :stored_as => :array, :class_name => "Badgeable::Badge", :inverse_of => :#{receiver.to_s.tableize}
      }

      Badgeable::Badge.class_eval %Q{
        references_many :#{receiver.to_s.tableize}, :inverse_of => :badges, :stored_as => :array, :inverse_of => :badges

        def recipients
          #{receiver}.where(:badge_ids => id)
        end
      }
    end
  end
end