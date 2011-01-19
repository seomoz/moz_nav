require 'rake'
require 'fileutils'

module MozNav
  class AssetSymlinker
    class PermissionsError < StandardError; end

    EXCLUDE_ASSET_DIRS = %w[markup sass]

    def initialize(host_app_asset_root)
      unless File.directory?(host_app_asset_root)
        raise ArgumentError.new("'#{host_app_asset_root}' is not a valid directory")
      end

      @host_app_asset_root = host_app_asset_root
    end

    def symlink_assets
      MozNav::ASSET_ROOT.children(:full_path).each do |moz_nav_path|
        symlink_dir(moz_nav_path)
      end
    end

    private

      def symlink_dir(moz_nav_path)
        base_moz_nav_path = File.basename(moz_nav_path)
        return if EXCLUDE_ASSET_DIRS.include?(base_moz_nav_path)

        host_app_path = File.join(@host_app_asset_root, base_moz_nav_path)
        FileUtils.mkdir_p(host_app_path)

        ensure_symlinked host_app_path + '/moz_nav', moz_nav_path.to_s
      rescue Errno::EACCES
        raise PermissionsError.new("You do not have proper file permissions to symlink the MozNav assets to #{@host_app_asset_root}")
      end

      def ensure_symlinked(from, to)
        if File.symlink?(from)
          return if File.readlink(from) == to

          # delete the old symlink
          File.unlink(from)
        end

        FileUtils.ln_s to, from
      end
  end
end

