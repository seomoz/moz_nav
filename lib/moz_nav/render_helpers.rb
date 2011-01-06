module MozNav
  module RenderHelpers
    def render_nav_header
      MozNav::Views::Example.render
    end

    def render_nav_footer
      "The footer"
    end
  end
end
