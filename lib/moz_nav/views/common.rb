module MozNav
  module Views
    module Common
      def seomoz_host
        MozNav::Config.seomoz_host
      end

      def q_and_a_host
        MozNav::Config.q_and_a_host
      end

      def environment
        MozNav::Config.environment
      end

      def cache_buster
        MozNav::VERSION
      end
    end
  end
end
