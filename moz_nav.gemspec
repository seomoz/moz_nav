# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "moz_nav/version"

Gem::Specification.new do |s|
  s.name        = "moz_nav"
  s.version     = MozNav::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Myron Marston"]
  s.email       = ["myron@seomoz.org"]
  s.homepage    = "https://github.com/seomoz/moz_nav"
  s.summary     = %q{SEO Moz Navigation}
  s.description = %q{Provides common navigational elements for SEO Moz applications.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
