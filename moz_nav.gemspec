# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "moz_nav/version"

Gem::Specification.new do |s|
  s.name        = "moz_nav"
  s.version     = MozNav::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Myron Marston", "Jeff Pollard"]
  s.email       = ["myron@seomoz.org", "jeff@seomoz.org"]
  s.homepage    = "https://github.com/seomoz/moz_nav"
  s.summary     = %q{SEO Moz Navigation}
  s.description = %q{Provides common navigational elements for SEO Moz applications.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency     'mustache', '~> 0.12.0'
  s.add_development_dependency 'sinatra'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'fuubar'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'markup_validity'
  s.add_development_dependency 'activesupport', '~> 6.0.0'
  s.add_development_dependency 'shotgun'
  s.add_development_dependency 'compass', '~> 0.11.beta.2'
  s.add_development_dependency 'oily_png'
  s.add_development_dependency 'postmark'
  s.add_development_dependency 'mail'
end
