module Badgeable
  class Config
    
    class << self
      attr_accessor :badge_definitions
    end
    
    attr_reader :threshold, :klass, :conditions_array, :subject_name
    
    def initialize
      @conditions_array = [Proc.new {true}]
      @subject_name = :user
    end
    
    def subject(sym)
      @subject_name = sym
    end
    
    def count(n = 1, &block)
      if block_given?
        count_proc = Proc.new { |instance|
          block.call(instance)
        }
      else
        count_proc = Proc.new { |instance|
          instance.instance_eval %Q{
            #{klass}.where(:#{subject_name}_id => #{subject_name}.id).count >= #{n}
          }
        }
      end
      @conditions_array << count_proc
    end
    
    def thing(klass)
      @klass = klass
    end
    
    def conditions(&block)
      @conditions_array << Proc.new {|instance|
        block.call(instance)
      }
    end 
  end
end