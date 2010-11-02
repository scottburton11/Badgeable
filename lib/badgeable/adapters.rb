module Badgeable
  module Adapters
    def self.connect(klass)
      klass.send(:include, Badgeable::Adapters::MongoidAdapter) if defined?(Mongoid) && klass.include?(::Mongoid::Document)
      klass.send(:include, Badgeable::Adapters::ActiveRecordAdapter) if defined?(ActiveRecord) && klass.superclass == ActiveRecord::Base
    end
  end
end