require 'rake'
require 'fileutils'

module MozNav
  class AssetSymlinker
    class PermissionsError < StandardError; end

    def initialize(host_app_asset_root)
      unless File.directory?(host_app_asset_root)
        raise ArgumentError.new("'#{host_app_asset_root}' is not a valid directory")
      end

      @host_app_asset_root = host_app_asset_root
    end

    def symlink_assets
      symlink_dir(MozNav::ASSET_ROOT.to_s)
    end

    private

      def symlink_dir(moz_nav_path)
        host_app_path = File.join(@host_app_asset_root, 'moz_nav_assets')
        ensure_symlinked host_app_path, moz_nav_path.to_s
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

