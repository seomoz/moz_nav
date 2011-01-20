module MozNav
  class PageConfig
    def page_title(val = nil)
      @page_title = val if val
      @page_title
    end

    def page_subtitle(val = nil)
      @page_subtitle = val if val
      @page_subtitle
    end

    def add_campaign(*args)
      campaigns << Campaign.new(*args)
    end

    def campaigns(val = nil)
      @campaigns ||= []
    end

    def has_campaigns?
      @campaigns && @campaigns.any?
    end

    def sub_nav_item(*args)
      sub_nav_items << SubNavItem.new(*args)
    end

    def sub_nav_items
      @sub_nav_items ||= []
    end
  end
end
