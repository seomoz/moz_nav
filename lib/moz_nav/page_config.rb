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

    VALID_NAV_ITEM_NAMES = [
      :about,
      :blog,
      :campaigns,
      :community,
      :dashboard,
      :features,
      :"learn-seo",
      :"pricing-plans",
      :"pro-qa",
      :research,
      :resources,
    ]

    def active_nav_item(val = nil)
      if val
        unless VALID_NAV_ITEM_NAMES.include?(val)
          raise ArgumentError.new("#{val.inspect} is not a valid nav item name.  Valid values are: #{VALID_NAV_ITEM_NAMES.inspect}")
        end
        @active_nav_item = val
      end
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

    def nav_item_class
      lambda do |item|
        klass = item
        item = item.to_sym

        unless VALID_NAV_ITEM_NAMES.include?(item)
          raise ArgumentError.new("#{item} is not a valid nav item name.  Valid values are: #{VALID_NAV_ITEM_NAMES.inspect}")
        end

        klass << " active" if item == active_nav_item
        klass
      end
    end
  end
end
