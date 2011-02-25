require 'pathname'
require 'moz_nav/railtie' if defined?(Rails::VERSION::MAJOR) && Rails::VERSION::MAJOR > 2

module MozNav
  extend self

  ROOT = Pathname.new(File.dirname(__FILE__))
  ASSET_ROOT = ROOT + 'moz_nav/assets'

  def configure
    yield Config
  end

  def ensure_assets_symlinked_from(host_app_dir)
    AssetSymlinker.new(host_app_dir).symlink_assets
  end

  autoload :ActiveNavItem,  'moz_nav/active_nav_item'
  autoload :AssetSymlinker, 'moz_nav/asset_symlinker'
  autoload :Campaign,       'moz_nav/campaign'
  autoload :Config,         'moz_nav/config'
  autoload :MustacheBase,   'moz_nav/mustache_base'
  autoload :PageConfig,     'moz_nav/page_config'
  autoload :RenderHelper,   'moz_nav/render_helper'
  autoload :SubNavItem,     'moz_nav/sub_nav_item'
  autoload :Version,        'moz_nav/version'

  module Views
    autoload :AdvancedBody,   'moz_nav/views/advanced_body'
    autoload :AdvancedFooter, 'moz_nav/views/advanced_footer'
    autoload :AdvancedHeader, 'moz_nav/views/advanced_header'
    autoload :BasicBody,      'moz_nav/views/basic_body'
    autoload :BasicFooter,    'moz_nav/views/basic_footer'
    autoload :BasicHeader,    'moz_nav/views/basic_header'
    autoload :Common,         'moz_nav/views/common'
    autoload :FooterIncludes, 'moz_nav/views/footer_includes'
    autoload :HeaderIncludes, 'moz_nav/views/header_includes'
  end
end

