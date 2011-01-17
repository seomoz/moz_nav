require 'pathname'
require 'moz_nav/railtie' if defined?(Rails)

module MozNav
  extend self

  ROOT = Pathname.new(File.dirname(__FILE__))
  ASSET_ROOT = ROOT + 'moz_nav/assets'

  def configure
    yield Config
  end

  autoload :Config,        'moz_nav/config'
  autoload :MustacheBase,  'moz_nav/mustache_base'
  autoload :PageConfig,    'moz_nav/page_config'
  autoload :RenderHelpers, 'moz_nav/render_helpers'
  autoload :Tasks,         'moz_nav/tasks'

  module Views
    autoload :AdvancedFooter, 'moz_nav/views/advanced_footer'
    autoload :AdvancedHeader, 'moz_nav/views/advanced_header'
    autoload :BasicFooter,    'moz_nav/views/basic_footer'
    autoload :BasicHeader,    'moz_nav/views/basic_header'
    autoload :Common,         'moz_nav/views/common'
    autoload :FooterIncludes, 'moz_nav/views/footer_includes'
    autoload :HeaderIncludes, 'moz_nav/views/header_includes'
  end
end

