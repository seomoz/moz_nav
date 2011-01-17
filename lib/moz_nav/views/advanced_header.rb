module MozNav
  module Views
    class AdvancedHeader < MozNav::MustacheBase
      include MozNav::Views::Common

      attr_reader :user
      attr_reader :page_config

      def initialize(user, page_config)
        @user, @page_config = user, page_config
      end
    end
  end
end

