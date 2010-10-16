module Badgeable
  module Award
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
    #              returns true, the badge is awarded. The first block 
    #              argument is the created instance of :thing. The 
    #              conditions directive may be called any number of times,
    #              and all conditions and the count block must return true.
    #              Also note that the conditions and count directives are
    #              evaluated separately.
    # 
    # See README for usage examples
    # 
    def badge(name, options = {}, &block)
      after_callback = options[:after] || :create
      config = Badgeable::Config.new
      config.instance_eval(&block)
      method_name = name.titleize.gsub(/\s/, "").underscore
      config.klass.class_eval do
        set_callback after_callback, :after, "award_#{method_name}_badge".to_sym
        define_method "award_#{method_name}_badge".to_sym, Proc.new {
          if config.conditions_array.all? {|p| p.call(self) }
            self.send(config.subject_proc.call(self)).award_badge(name)
          end
        }
      end
    end
  end
end