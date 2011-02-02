module MozNav
  module RenderHelper
    
    def render_nav_wrapped(content, &block)
      render_nav_header(&block) + 
      render_nav_body(content, &block) + 
      render_nav_footer
    end
    
    def render_nav_header
      yield page_config = PageConfig.new

      if current_user && current_user.pro?
        MozNav::Views::AdvancedHeader.new(current_user, page_config).render
      else
        MozNav::Views::BasicHeader.new(current_user, page_config).render
      end
    end
    
    def render_nav_body(content)
      yield page_config = PageConfig.new
      
      if current_user && current_user.pro?
        MozNav::Views::AdvancedBody.new(content, page_config).render
      else
        MozNav::Views::BasicBody.new(content, page_config).render
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

    def nav_footer_includes(*args)
      MozNav::Views::FooterIncludes.new(*args).render
    end
  end
end
