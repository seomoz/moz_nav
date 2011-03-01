module MozNav
  module Config
    class << self
      attr_writer :seomoz_host
      def seomoz_host
        @seomoz_host ||= 'www.seomoz.org'
      end

      attr_writer :q_and_a_host
      def q_and_a_host
        @q_and_a_host ||= 'www.seomoz.org'
      end

      attr_writer :environment
      def environment
        @environment ||= if defined?(Rails) && %w[production staging].include?(Rails.env)
          'production'
        else
          'development'
        end
      end

      attr_writer :asset_path_prefix
      def asset_path_prefix
        @asset_path_prefix ||= ''
      end

      def reset!
        instance_variables.each do |var|
          remove_instance_variable(var)
        end
      end
    end
  end
end
