module MozNav
  class ActiveNavItem
    VALID_NAV_ITEM_NAMES = [
      :about,
      :blog,
      :campaigns,
      :community,
      :dashboard,
      :features,
      :learn_seo,
      :pricing_plans,
      :pro_qa,
      :research,
      :resources,
    ]

    def initialize(item)
      if item && !VALID_NAV_ITEM_NAMES.include?(item)
        raise ArgumentError.new("#{item.inspect} is not a valid nav item name.  Valid values are: #{VALID_NAV_ITEM_NAMES.inspect}")
      end

      @item = item
    end

    VALID_NAV_ITEM_NAMES.each do |item|
      define_method :"#{item}?" do
        @item == item
      end
    end
  end
end
