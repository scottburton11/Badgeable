require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'
require 'badgeable/railtie' if defined?(Rails)

module Badgeable
  autoload :Adapters,     'badgeable/adapters'
  autoload :Award,        'badgeable/award'
  autoload :Config,       'badgeable/config'
  autoload :Dsl,          'badgeable/dsl'
  autoload :Subject,      'badgeable/subject'
  autoload :Verson,       'badgeable/version'
  module Adapters
    autoload :ActiveRecordAdapter, "badgeable/adapters/active_record_adapter"
    autoload :MongoidAdapter,      "badgeable/adapters/mongoid_adapter"
  end
end

module Badgeable; end