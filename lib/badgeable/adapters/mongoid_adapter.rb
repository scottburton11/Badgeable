module Badgeable
  module Adapters
    module MongoidAdapter
      def self.included(receiver)
        receiver.class_eval do
          embeds_many :badgings
        end
        
        ::Badging.class_eval %Q{
          embedded_in :#{receiver.to_s.underscore}, :inverse_of => :badgings
          def receiver
            #{receiver.to_s.underscore}
          end
        }
        
        ::Badge.class_eval %Q{
          def recipients
            #{receiver}.where("badgings.badge_id" => id)
          end
        }
        receiver.send(:include, InstanceMethods)
      end
    end
    
    module InstanceMethods
      def award_badge(name)
        badge = Badge.find_or_create_by_name(name)
        badgings.create(:badge_id => badge.id) unless has_badge?(badge)
      end
      
      def badges
        Badge.where(:_id.in => badgings.map(&:badge_id))
      end
      
      def unseen_badges
        Badge.where(:_id.in => badgings.unseen.map(&:badge_id))
      end
    end
  end
end