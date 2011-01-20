module MozNav
  module Routes
    class Base
      class UndefinedRouteError < NotImplementedError; end

      class << self
        def types
          @types ||= []
        end

        def route_types(*types)
          types.each do |type|
            define_method(type) { |&b| routes[type] = b }
            self.types << type
          end
        end
      end

      def route_for(type)
        routes[type] or raise ArgumentError.new("No route could be found for #{type.inspect}")
      end

      def verify_all_routes!
        undefined_routes = self.class.types - routes.keys
        if undefined_routes.any?
          raise UndefinedRouteError.new("The following routes have not been defined: #{undefined_routes.join(', ')}")
        end
      end

      private

        def routes
          @routes ||= {}
        end
    end
  end
end

