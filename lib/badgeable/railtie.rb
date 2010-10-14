module Badgeable
  class Railtie < ::Rails::Railtie
    initializer "badgeable.assign_badge_definitions_file" do
      Badgeable::Config.badge_definitions = Pathname.new("#{Rails.root}/lib/badges.rb")
    end
    
    config.to_prepare "badgeable.load_badges" do
      Badgeable::Dsl.class_eval(File.read(Badgeable::Config.badge_definitions))
    end
  end
end