require 'set'

module Badgeable
  class Config
    
    class << self
      attr_accessor :badge_definitions

      def custom_attributes
        @custom_attributes ||= Set.new([:icon, :description])
      end
    end
    
    attr_reader :threshold, :klass, :conditions_array, :subject_proc
    
    def initialize
      @conditions_array = [Proc.new {true}]
      subject :user
    end
    
    def subject(sym = nil, &block)
      @subject_name = sym
      if block_given?
        @subject_proc = Proc.new {|instance|
          block.call(instance)
        }
      else
        @subject_proc = Proc.new { |instance|
          if klass.to_s.underscore.to_sym == @subject_name
            instance
          else
            instance.send(sym)
          end
        }
      end
    end
    
    def count(n = 1, &block)
      if block_given?
        count_proc = Proc.new { |instance|
          block.call(instance)
        }
      else
        count_proc = Proc.new { |instance|
          instance.instance_eval %Q{
            #{klass}.where(:#{@subject_name}_id => #{@subject_name}.id).count >= #{n}
          }
        }
      end
      @conditions_array << count_proc
    end
   
    def icon(*args)
      raise ArgumentError unless args.length <= 1
      if args.length == 1
        @icon = args[0]
      else
        @icon
      end
    end
    
    def description(*args)
      raise ArgumentError unless args.length <= 1
      if args.length == 1
        @description = args[0]
      else
        @description
      end
    end
   

    def thing(klass)
      @klass = klass
    end
    
    def conditions(&block)
      @conditions_array << Proc.new {|instance|
        block.call(instance)
      }
    end 
   
    # If an undefined method is called with arguments, treat it 
    # as a custom attribute setter.
    def method_missing(meth, *args, &blk)
      if args.length > 0
        self.class.add_custom_attribute meth
        send meth, *args, &blk
      else
        super meth, *args, &blk
      end
    end

    def self.add_custom_attribute(attribute)
      define_method attribute.to_sym, lambda { |*args|
        raise ArgumentError unless args.length <= 1
        if args.length == 1
          instance_variable_set :"@#{attribute}", args[0]
        else
          instance_variable_get :"@#{attribute}"
        end        
      }
      custom_attributes << attribute
    end
    
  end
end