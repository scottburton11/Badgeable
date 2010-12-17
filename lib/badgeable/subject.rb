module Badgeable
  module Subject
    # Award a named badge to this object. If the badge doesn't exist
    # in the database already, it's created by name.
    def award_badge(*args)
      options = args.extract_options!
      name = args[0]
      badge = Badge.find_or_create_by_name(name, options)
      badges << badge unless has_badge?(badge)      
    end
    
    def has_badge?(badge)
      badges.include?(badge)
    end
    
    def has_badge_named?(name)
      badges.map(&:name).include?(name)
    end
    
    def self.included(receiver)
      Badgeable::Adapters.connect(receiver)
    end
  end
end