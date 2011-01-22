module MozNav
  module Views
    class FooterIncludes < MozNav::MustacheBase
      include Common

      def initialize(options = {})
        @options = options
      end

      def include_jquery?
        @options[:jquery]
      end
    end
  end
end

