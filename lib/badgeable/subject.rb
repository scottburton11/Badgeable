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
  end
end