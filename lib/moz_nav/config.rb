module MozNav
  module Config
    class << self
      attr_writer :seomoz_host
      def seomoz_host
        @seomoz_host ||= 'www.seomoz.org'
      end

      def reset!
        instance_variables.each do |var|
          remove_instance_variable(var)
        end
      end
    end
  end
end
