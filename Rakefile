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

namespace :compass do
  desc "Starts a process that watches changes to the sass files and compiles them to css."
  task :watch do
    sh "compass watch"
  end
  
  desc "Compile the SASS as minified CSS for production"
  task :compile_for_prod do
    sh "compass compile --css-dir stylesheets/production/ --environment production --force --output-style compressed"
  end
end

task :default => :spec

# Make sure we never push to rubygems.org
Bundler::GemHelper.class_eval do
  def release_gem
    guard_clean

    Rake::Task['sass:compile_for_prod'].invoke
    sh "git add lib/moz_nav/assets/stylesheets/production/*"
    unless `git status` =~ /nothing to commit/
      sh "git commit -m 'Updated production stylesheet'"
    end

    guard_already_tagged
    tag_version { git_push }
  end
end



