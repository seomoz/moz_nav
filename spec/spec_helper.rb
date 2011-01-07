require 'rubygems'
require 'bundler'
Bundler.setup

require 'rspec'
require 'moz_nav'
require 'markup_validity'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require File.join("support", File.basename(f))}

Capybara.app = ExampleApp
Capybara.save_and_open_page_path = File.join(File.dirname(__FILE__), '../tmp/capybara')

RSpec.configure do |config|
  config.color_enabled = true
  config.debug = true

  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true

  config.alias_it_should_behave_like_to :it_presents, "it presents"
  config.alias_it_should_behave_like_to :it_has,      "it has"
  config.include MozNavSpecSelectors
  config.include Spec::Matchers # for markup_validity matchers

  config.after(:each) do
    MozNav::Config.reset!
  end
end

module Spec
  module Matchers
    Matcher = RSpec::Matchers::Matcher
  end
end

