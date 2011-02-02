module MozNav
  module Views
    class BasicHeader < MozNav::MustacheBase
      include MozNav::Views::Common

      attr_reader :user
      attr_reader :page_config

      def initialize(user, page_config)
        @user, @page_config = user, page_config
      end

      def logged_in?
        !!user
      end
    end
  end
end


