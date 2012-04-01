module Badgeable
  module Generators
    class DefinitionsGenerator < Badgeable::Generators::Base
      def create_badge_definitions_file
        lib "badges.rb", "# Define your badges here; see https://github.com/scottburton11/Badgeable for details"
      end
    end
  end
end