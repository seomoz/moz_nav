require 'mustache'

module MozNav
  class MustacheBase < Mustache
    self.view_path      = MozNav::Root + 'moz_nav/views'
    self.template_path  = MozNav::Root + 'moz_nav/templates'
    self.view_namespace = MozNav

    def self.inherited(subclass)
      # for some reason, this setting isn't properly inherited, so we need to
      # set it directly on the subclass
      subclass.raise_on_context_miss = true
    end

    def render(*args)
      result = super

      # Handle html safety for rails
      result.respond_to?(:html_safe) ? result.html_safe : result
    end
  end
end

