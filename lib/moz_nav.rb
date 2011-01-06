require 'pathname'

module MozNav
  Root = Pathname.new(File.dirname(__FILE__))

  autoload :MustacheBase,  'moz_nav/mustache_base'
  autoload :RenderHelpers, 'moz_nav/render_helpers'

  module Views
    autoload :BasicHeader, 'moz_nav/views/basic_header'
  end
end

