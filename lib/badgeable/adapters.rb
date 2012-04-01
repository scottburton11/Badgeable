module Badgeable
  module Adapters

    class << self
      attr_accessor :current_adapter
    end

    def self.use(adapter)
      @current_adapter = adapter
    end

    def self.supported_adapters
      [:active_record, :mongoid]
    end

    def self.connect(klass)
      raise ArgumentError, "Badgeable needs a database adapter to work. Add one of the following to your Gemfile: #{Badgeable::Adapters.supported_adapters.map {|name| 'badgeable_' + name }}" unless Badgeable::Adapters.current && (Badgeable::Adapters.supported_adapters.include? Badgeable::Adapters.current)
      klass.send(:include, Badgeable::Adapters.const_get(Badgeable::Adapters.current.titleize + "Adapter" ))
    end
  end
end