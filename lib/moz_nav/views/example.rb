module MozNav
  module Views
    class Example < MozNav::MustacheBase
      def name
        "Chris"
      end

      def value
        10_000
      end

      def taxed_value
        value - (value * 0.4)
      end

      def in_ca
        true
      end
    end
  end
end

