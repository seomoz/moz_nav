module MozNav
  module Views
    class AdvancedHeader < MozNav::MustacheBase
      include MozNav::Views::Common

      attr_reader :user
      attr_reader :page_config
      attr_reader :campaign

      def initialize(user, campaign, page_config)
        @user, @campaign, @page_config = user, campaign, page_config
      end
    end
  end
end

