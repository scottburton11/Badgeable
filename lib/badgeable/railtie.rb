module Badgeable
  class Railtie < ::Rails::Railtie

    def badge_definition_file
      "#{Rails.root}/lib/badges.rb"
    end

    initializer "badgeable.assign_badge_definitions_file" do
      if File.exists?(badge_definition_file)
        Badgeable::Config.badge_definitions = File.read(Pathname.new(badge_definition_file))
      else
        Rails.logger.warn "Badgeable badges.rb file not found; add your badge definitions to #{badge_definition_file}, or run `rails g badgeable:setup` to get started"
        Badgeable::Config.badge_definitions = ""
      end
    end
    
    config.to_prepare do
      Badgeable::Dsl.class_eval Badgeable::Config.badge_definitions
    end

    generators do
      require "generators/badgeable_generator"
      require "generators/setup/definitions_generator"
    end
  end
end