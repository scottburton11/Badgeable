$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'lib/badgeable'
 
task :build do
  system "gem build badgeable.gemspec"
end
 
task :release => :build do
  system "gem push badgeable-#{Badgeable::VERSION}.gem"
end