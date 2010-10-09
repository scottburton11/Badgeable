module Badgeable
  class Config
    # Configure a class to automatically award badges after creation.
    # Assign a badge name and a block with configuration
    # directives.
    # 
    # Valid directives:
    # 
    # thing        (Required) a class constant in this namespace that 
    #              awards the badge.
    # subject      (Optional, default = :user) a symbol that references
    #              the object to which the badge is awarded. This should
    #              be a related object that includes Badgeable, and will
    #              usually have referenced_in :thing, belongs_to :thing etc.
    # count        (Optional, default = 1) either an integer threshold value
    #              of :things related to :subject, or a block. If a block
    #              is given, the created instance of :thing is passed as
    #              the first block argument, and the block must return
    #              return true for the badge to be awarded.
    # conditions   (Optional) provide a block; if your block returns 
    #              returns true, the badge is awarded. Works in
    #              conjunction with #count
    # 
    # See README for usage examples
    # 
    def self.badge(name, &block)
      config = new
      config.instance_eval(&block)
      method_name = name.titleize.gsub(/\s/, "").underscore
      config.klass.class_eval do
        set_callback :create, :after, "award_#{method_name}_badge".to_sym
        define_method "award_#{method_name}_badge".to_sym, Proc.new {
          if config.conditions_array.all? {|p| p.call(self) }
            self.send(config.subject_name).award_badge(name)
          end
        }
      end
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