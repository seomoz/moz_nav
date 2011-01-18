module MozNav
  module RenderHelpers
    def render_nav_header
      yield page_config = PageConfig.new

      if current_user && current_user.pro?
        MozNav::Views::AdvancedHeader.new(current_user, page_config).render
      else
        MozNav::Views::BasicHeader.new(current_user).render
      end
    end

    def render_nav_footer
      if current_user && current_user.pro?
        MozNav::Views::AdvancedFooter.render
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
