require 'sass'

Sass::Tree::PropNode.class_eval do
  def _to_s_with_important(*args)
    css = _to_s_without_important(*args)

    # force all properties to have !important to work with the cleanslate styles.
    unless css =~ /!important;$/
      css = css.gsub(/;$/, ' !important;')
    end

    css
  end

  alias _to_s_without_important _to_s
  alias _to_s _to_s_with_important
end
