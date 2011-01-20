module MozNav
  class SubNavItem
    attr_reader :name, :url

    def initialize(name, url, options = {})
      @name, @url, @options = name, url, options
    end

    def active?
      !!@options[:active]
    end
  end
end

