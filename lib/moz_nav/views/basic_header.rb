module MozNav
  module Views
    class BasicHeader < MozNav::MustacheBase
      include MozNav::Views::Common
      attr_reader :user

      def initialize(user)
        @user = user
      end

      def logged_in?
        !!user
      end
    end
  end
end


