require 'sass'

module MozNav
  module Extensions
    module SassToCss
      def new(*args)
        super.extend Extension
      end

      module Extension
        protected

        def visit_prop(node)
          super.tap do |css|
            # force all properties to have !important to work with the cleanslate styles.
            css.sub!(/(;?)$/, ' !important\1') unless css =~ /!important;?$/
          end
        end
      end
    end
  end
end

Sass::Tree::Visitors::ToCss.extend MozNav::Extensions::SassToCss
