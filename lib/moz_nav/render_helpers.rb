module MozNav
  module RenderHelpers
    def render_nav_header
      if current_user && current_user.pro?
        MozNav::Views::AdvancedHeader.new(current_user).render
      else
        MozNav::Views::BasicHeader.render
      end
    end

    def render_nav_footer
      if current_user && current_user.pro?
        # TODO
      else
        MozNav::Views::BasicFooter.render
      end
    end

    def nav_header_includes
      MozNav::Views::HeaderIncludes.render
    end

    def nav_footer_includes
      MozNav::Views::FooterIncludes.render
    end
  end
end
