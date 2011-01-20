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

    def campaigns(val = nil)
      @campaigns = val if val
      @campaigns ||= []
      @campaigns
    end

    def has_campaigns?
      @campaigns && @campaigns.any?
    end

    def campaign_routes
      @campaign_routes ||= MozNav::Routes::Campaign.new
      yield @campaign_routes if block_given?
      @campaign_routes
    end

    # define convience methods so we don't have to nest mustache tags so deeply
    MozNav::Routes::Campaign.types.each do |type|
      define_method :"campaign_#{type}_url" do
        campaign_routes.route_for(type)
      end
    end
  end
end
