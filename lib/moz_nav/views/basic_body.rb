module MozNav
  module Views
    class BasicBody < MozNav::MustacheBase
      include MozNav::Views::Common
      
      attr_reader :page_content
      attr_reader :page_config
      
      def initialize(page_content, page_config)
        @page_content, @page_config = page_content, page_config
      end
      
    end
  end
end


