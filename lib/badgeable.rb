require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'mongoid'
require 'badgeable/badge'
require 'badgeable/config'
require 'badgeable/subject'

module Badgeable  
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
    
    receiver.send :include, Badgeable::Subject
  end
end