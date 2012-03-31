module Badgeable
  module Adapters

    def self.current
      @current_adapter
    end

    def self.use(adapter)
      @current_adapter = adapter
    end

    def self.supported_adapters
      [:active_record, :mongoid]
    end

    def self.connect(klass)
      # klass.send(:include, Badgeable::Adapters::MongoidAdapter) if defined?(Mongoid) && klass.include?(::Mongoid::Document)
      # klass.send(:include, Badgeable::Adapters::ActiveRecordAdapter) if defined?(ActiveRecord) && klass.superclass == ActiveRecord::Base
      raise ArgumentError, "Badgeable needs a database adapter to work. Add one of the following to your Gemfile: #{Badgeable::Adapters.supported_adapters.map {|name| 'badgeable_' + name }}" unless Badgeable::Adapters.current && (Badgeable::Adapters.supported_adapters.include? Badgeable::Adapters.current)
      klass.send(:include, Badgeable::Adapters.const_get(Badgeable::Adapters.current.titleize + "Adapter" ))
    end
  end
end