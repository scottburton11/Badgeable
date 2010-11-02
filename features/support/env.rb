$:.unshift(File.expand_path(File.join(File.dirname(__FILE__),'..', '..', 'lib')))

require 'cucumber'
require 'rspec/expectations'
require 'badgeable'
require 'mongoid'

Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("badgeable_test")
end

# factory_girl Factory definitions
Dir[(File.expand_path(File.dirname(__FILE__), "..") + "spec/factories/**/*.rb").to_s].each {|factory| require factory}

Dir[(File.expand_path(File.dirname(__FILE__)) + "test_models/**/*.rb")].each {|model| require model }

Before do
  Mongoid.master.collections.select{|c| !c.name.starts_with?("system")}.each(&:drop)
end
