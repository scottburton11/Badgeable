require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'active_support/dependencies'
require 'active_support/concern'

# if defined?(Mongoid)
  autoload :Badge,   'badgeable/adapters/mongoid_adapter/badge'
  autoload :Badging, 'badgeable/adapters/mongoid_adapter/badging'
# end
# 
# if defined?(ActiveRecord)
#   autoload :Badge,   'badgeable/adapters/active_record/badge'
#   autoload :Badging, 'badgeable/adapters/active_record/badging'
# end


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

require 'badgeable/railtie' if defined?(Rails)

module Badgeable; end