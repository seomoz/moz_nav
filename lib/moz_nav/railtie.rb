require 'rails'
require 'moz_nav'

module MozNav
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'moz_nav/tasks/moz_nav.rake'
    end
  end
end
