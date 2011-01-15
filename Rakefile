require 'bundler'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example_app do
  desc "Serves the example sinatra app used by the specs so you can use it in your browser"
  task :serve do
    sh "bundle exec shotgun config.ru -p 3000"
  end
end

namespace :sass do
  desc "Starts a process that watches changes to the sass files and compiles them to css."
  task :watch do
    sh %w[
      sass
      --watch lib/moz_nav/assets/sass:lib/moz_nav/assets/stylesheets
      --cache-location tmp/sass_cache
      --require lib/moz_nav/extensions/sass.rb
    ].join(' ')
  end
end

load 'moz_nav/tasks/moz_nav.rake'

task :default => :spec

# Make sure we never push to rubygems.org
Bundler::GemHelper.class_eval do
  def rubygems_push
    puts "skipping rubygems push since this gem isn't meant to be publicly released"
  end
end
