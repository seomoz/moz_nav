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

namespace :pack do

  desc "Pack assets for use in www.seomoz.org"
  task :assets_for_seomoz do
    Rake::Task['compass:compile_for_prod'].invoke
    FileUtils.rm_rf('assets_for_seomoz')

    { 'stylesheets/production' => 'css', 'images' => 'images', 'javascripts' => 'js'}.each do |ours, theirs|
        FileUtils.mkdir_p("assets_for_seomoz/#{theirs}")
        FileUtils.cp_r("lib/moz_nav/assets/#{ours}", "assets_for_seomoz/#{theirs}/moz_nav")
    end

    sh "tar -cvf moznav_assets.#{MozNav::VERSION}.tar assets_for_seomoz/"
    FileUtils.rm_rf('assets_for_seomoz')
  end
end

task :default => :spec

# Make sure we never push to rubygems.org
Bundler::GemHelper.class_eval do
  def release_gem
    guard_clean

    Rake::Task['compass:compile_for_prod'].invoke
    sh "git add lib/moz_nav/assets/stylesheets/production/*"
    unless `git status` =~ /nothing to commit/
      sh "git commit -m 'Updated production stylesheet'"
    end

    guard_already_tagged
    tag_version { git_push }
  end
end



