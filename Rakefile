require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example_app do
  desc "Serves the example sinatra app used by the specs so you can use it in your browser"
  task :serve do
    sh "bundle exec rackup config.ru"
  end
end

load 'moz_nav/tasks/moz_nav.rake'

task :default => :spec
