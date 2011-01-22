module MozNav
  module Config
    class << self
      attr_writer :seomoz_host
      def seomoz_host
        @seomoz_host ||= 'www.seomoz.org'
      end

      attr_writer :q_and_a_host
      def q_and_a_host
        @a_and_a_host ||= 'www.seomoz.org'
      end

      attr_writer :environment
      def environment
        @environment ||= if defined?(Rails) && %w[production staging].include?(Rails.env)
          'production'
        else
          'development'
        end
      end

      def reset!
        instance_variables.each do |var|
          remove_instance_variable(var)
        end
      end
    end
  end
end
