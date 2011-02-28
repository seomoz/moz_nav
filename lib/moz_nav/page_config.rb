module MozNav
  class PageConfig
    def initialize
      # ensure #active_nav_item always returns something
      @active_nav_item = ActiveNavItem.new(nil)
    end

    def page_title(val = nil)
      @page_title = val if val
      @page_title
    end

    def page_subtitle(val = nil)
      @page_subtitle = val if val
      @page_subtitle
    end

    def active_nav_item(val = nil)
      @active_nav_item = ActiveNavItem.new(val.to_sym) if val
      @active_nav_item
    end
    
    def page_icon(val = nil)
      @page_icon = val if val
      @page_icon
    end

    def has_icon?
      @page_icon && !@page_icon.empty?
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

    def sub_nav_item(*args, &block)
      sub_nav_items << SubNavItem.new(*args, &block)
    end

    def sub_nav_items
      @sub_nav_items ||= []
    end

    def active_sub_nav_item
      active = sub_nav_items.select(&:active?)

      if active.size > 1
        raise "There are multiple active sub nav items: #{active.map(&:name).join(', ')}"
      end

      active.first
    end

    def has_blue_header_content?
      page_title.to_s != '' ||
      page_subtitle.to_s != '' ||
      has_campaigns?
    end

    def has_sub_nav_items?
      !sub_nav_items.empty?
    end
  end
end
