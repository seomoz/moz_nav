require 'forwardable'

module MozNav
  module Views
    class AdvancedHeader < MozNav::MustacheBase
      extend Forwardable
      include MozNav::Views::Common

      attr_reader :user
      attr_reader :page_config

      def_delegators :page_config, :page_title, :page_subtitle

      def initialize(user, page_config)
        @user, @page_config = user, page_config
      end

      def user_id
        user.id
      end
    end
  end
end

