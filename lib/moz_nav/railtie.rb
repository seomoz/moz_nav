require 'rails'
require 'moz_nav'

module MozNav
  class Railtie < Rails::Railtie
    initializer 'moz_nav.symlink_assets' do
      MozNav.ensure_assets_symlinked_from(Rails.public_path)
    end
  end
end
