require 'pathname'

module MozNav
  Root = Pathname.new(File.dirname(__FILE__))

  autoload :RenderHelpers, 'moz_nav/render_helpers'
  autoload :MustacheBase,  'moz_nav/mustache_base'

  module Views
    autoload :Example, 'moz_nav/views/example'
  end
end

