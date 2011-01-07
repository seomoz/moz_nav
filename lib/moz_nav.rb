require 'pathname'

module MozNav
  extend self

  Root = Pathname.new(File.dirname(__FILE__))

  def configure
    yield Config
  end

  autoload :Config,        'moz_nav/config'
  autoload :MustacheBase,  'moz_nav/mustache_base'
  autoload :RenderHelpers, 'moz_nav/render_helpers'

  module Views
    autoload :AdvancedHeader, 'moz_nav/views/advanced_header'
    autoload :BasicHeader,    'moz_nav/views/basic_header'
    autoload :Common,         'moz_nav/views/common'
  end
end

