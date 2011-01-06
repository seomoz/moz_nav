require 'mustache'

module MozNav
  class MustacheBase < Mustache
    self.view_path      = MozNav::Root + 'moz_nav/views'
    self.template_path  = MozNav::Root + 'moz_nav/templates'
    self.view_namespace = MozNav
  end
end

