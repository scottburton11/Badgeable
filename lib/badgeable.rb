require 'active_support/core_ext'
require 'active_support/callbacks'
require 'active_support/inflector'
require 'mongoid'
require 'badgeable/award'
require 'badgeable/badge'
require 'badgeable/config'
require 'badgeable/dsl'
require 'badgeable/subject'
require 'badgeable/version'
require 'badgeable/railtie' if defined?(Rails)

module Badgeable; end