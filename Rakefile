require 'bundler'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :example_app do
  desc "Serves the example sinatra app used by the specs so you can use it in your browser"
  task :serve do
    sh "bundle exec shotgun config.ru -p 3000"
  end

  desc "Serves the app under '/q' like the Q&A app is."
  task :q_and_a do
    sh "bundle exec thin -R config.ru --prefix=/q start"
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

  task :compile_and_commit_prod => :compile_for_prod do
    sh "git add lib/moz_nav/assets/stylesheets/production/*"
    unless `git status` =~ /nothing to commit/
      sh "git commit -m 'Updated production stylesheet'"
    end
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

    sh "tar -cvf pkg/moznav_assets.#{MozNav::VERSION}.tar assets_for_seomoz/"
    FileUtils.rm_rf('assets_for_seomoz')
  end
end

task :default => :spec

desc "Sends a notification email about a MozNav release"
task :send_release_notification do
  require 'mail'
  require 'postmark'
  require 'json'

  def sortable_tag(tag)
    Gem::Version.new(tag.sub('v', ''))
  end

  prev_tag, new_tag = `git tag`.split.sort { |a, b| sortable_tag(a) <=> sortable_tag(b) }.last(2)
  changelog_url = "https://github.com/seomoz/MozNav/compare/#{prev_tag}...#{new_tag}"
  email = 'moznav@seomoz.org'

  message = Mail.new do
            from 'dev@seomoz.org'
        reply_to email
              to email
         subject "New MozNav release: #{new_tag}"
    content_type 'text/plain'
            body <<-BODY
Version #{new_tag.sub(/^v/, '')} of the MozNav gem has been released.

Changelog:

  #{changelog_url}
BODY
  end

  message.delivery_method Mail::Postmark, :api_key => "<REDACTED>"
  message.deliver
end

# Make sure we never push to rubygems.org,
# And add our own release processing:
#   - re-compile production stylesheet
#   - send notification email to moznav@seomoz.org
Bundler::GemHelper.class_eval do
  def release_gem
    guard_clean
    Rake::Task['compass:compile_and_commit_prod'].invoke
    guard_already_tagged
    tag_version { git_push }
    Rake::Task['send_release_notification'].invoke
  end
end



