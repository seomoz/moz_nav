namespace :moz_nav do
  desc "Symlinks the asset folders so they are available to the host application."
  task :symlink_assets do
    require 'moz_nav'
    MozNav::Tasks.symlink_assets
  end
end
