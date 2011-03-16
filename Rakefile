require 'bundler'
require 'bundler/setup'
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

namespace :cruise do
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = %w[--format progress]
  end
end

desc "Build task for cruise control"
task :cruise => ['cruise:spec']

namespace :example_app do
  desc "Serves the example sinatra app used by the specs so you can use it in your browser"
  task :serve do
    sh "bundle exec shotgun config.ru -p 3000"
  end

  desc "Serves the app under '/q' like the Q&A app is."
  task :qa do
    sh "ASSET_PATH_PREFIX='/q' bundle exec thin -R config.ru --prefix=/q start"
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

  def post_mark_api_key
    @post_mark_api_key ||= begin
      home_dir = `echo $HOME`.strip
      filename = "#{home_dir}/.post_rank_api_key"
      if File.exist?(filename)
        File.read(filename)
      else
        require 'highline'

        HighLine.new.ask("#{filename} does not exist.  Please enter your post rank API key: ") do |q|
          q.validate = /\A[a-f0-9]{8}(\-[a-f0-9]{4}){3}\-[a-f0-9]{12}\z/
        end.tap do |api_key|
          File.open(filename, 'w') { |f| f.write(api_key) }
        end
      end
    end
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

  message.delivery_method Mail::Postmark, :api_key => post_mark_api_key
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
    sh "git push origin HEAD:release"
    Rake::Task['send_release_notification'].invoke
  end
end
