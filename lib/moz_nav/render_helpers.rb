module MozNav
  module RenderHelpers
    def render_nav_header
      if current_user && current_user.pro?
        MozNav::Views::AdvancedHeader.render
      else
        MozNav::Views::BasicHeader.render
      end
    end

    def render_nav_footer
      "The footer"
    end
  end
end
