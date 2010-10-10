# -*- encoding: utf-8 -*-
require File.expand_path("../lib/badgeable/version", __FILE__)
 

Gem::Specification.new do |s|
  s.name        = "badgeable"
  s.version     = Badgeable::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Scott Burton"]
  s.email       = ["scottburton11@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/badgeable"
  s.summary     = "Badgeable is an elegant DSL for awarding badges"
  s.description = "Badgeable provides an elegant DSL for describing and awarding badges to your Ruby objects."
 
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "badgeable"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", ">= 2.0.0.rc"
  s.add_development_dependency "cucumber"
  s.add_development_dependency "factory_girl", ">= 1.3.2"
  
  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end