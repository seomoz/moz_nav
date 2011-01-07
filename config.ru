require 'rubygems'
require 'bundler'
Bundler.setup

$LOAD_PATH.unshift File.expand_path('../app', __FILE__)
require 'app'

use Rack::ShowExceptions

run ExampleApp.new

