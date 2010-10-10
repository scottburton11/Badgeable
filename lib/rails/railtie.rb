module Badgeable
  module Rails
    class Railtie < ::Rails::Railtie
      initializer "badgeable.load_badges" do
        Badgeable::Config.badge_definitions = Pathname.new("#{Rails.root}/lib/badges.rb")
        Badgeable::Award.class_eval(File.read(Badgeable::Config.badge_definitions))
      end
    end
  end
end