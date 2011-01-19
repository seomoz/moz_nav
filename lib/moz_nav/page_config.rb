module MozNav
  class PageConfig
    class Campaign
      attr_reader :name, :url
      def initialize(name, url)
        @name, @url = name, url
      end
    end

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

    def campaigns
      @campaigns ||= []
    end

    def has_campaigns?
      campaigns.any?
    end
  end
end
