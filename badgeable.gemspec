# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
 
require 'lib/badgeable'
 
Gem::Specification.new do |s|
  s.name        = "badgeable"
  s.version     = Badgeable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scott Burton"]
  s.email       = ["scottburton11@gmail.com"]
  s.homepage    = "http://github.com/scottburton11/badgeable"
  s.summary     = "Badgeable is an elegant DSL for awarding badges"
  s.description = "Badgeable provides an elegant DSL for describing and awarding badges to your Ruby objects."
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README.rdoc)
  s.require_path = 'lib'
end