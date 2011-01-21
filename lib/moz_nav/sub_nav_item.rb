module MozNav
  class MenuItemBase
    attr_reader :name, :url

    def initialize(name, url, options = {})
      @name, @url, @options = name, url, options
    end

    def active?
      !!@options[:active]
    end
  end

  class SubNavItem < MenuItemBase
    def initialize(*args)
      super

      yield self if block_given?
    end

    def sub_sub_nav_item(*args)
      sub_sub_nav_items << SubSubNavItem.new(*args)
    end

    def has_sub_sub_nav_items?
      !sub_sub_nav_items.empty?
    end

    def sub_sub_nav_items
      @sub_sub_nav_items ||= []
    end
  end

  class SubSubNavItem < MenuItemBase
  end
end

