require 'rubygems'
require 'bundler'
Bundler.setup

require 'moz_nav'
require File.expand_path('../spec/support/example_app', __FILE__)

use Rack::ShowExceptions

run ExampleApp.new

