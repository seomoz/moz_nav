module MozNav
  module Views
    class AdvancedHeader < MozNav::MustacheBase
      include MozNav::Views::Common

      attr_reader :user

      def initialize(user)
        @user = user
      end

      def user_id
        user.id
      end
    end
  end
end

