require 'spec_helper'

class ExampleMustache < MozNav::MustacheBase
end

module MozNav
  describe ExampleMustache do
    MARKUP = "<p>Hello</p>"

    def perform_render
      ExampleMustache.render(MARKUP)
    end

    context 'when activesupport html safety is not loaded' do
      before(:each) do
        "".should_not respond_to(:html_safe?)
        defined?(ActiveSupport).should be_false
      end

      it 'renders the markup correctly' do
        perform_render.should == MARKUP
      end
    end

    context 'when used in a rails context that auto-escapes unsafe strings' do
      it 'renders the markup correctly' do
        # this must run in a sub process so that we don't
        # "pollute" the main process with activesupport.
        # If we did that, we wouldn't be able to properly run a
        # test w/o activesupport since we can't "unrequire" a
        # library once it is loaded.
        output = in_sub_process do
          require 'active_support/core_ext/string/output_safety'
          "".should respond_to(:html_safe?)
          ERB::Util.html_escape perform_render
        end

        output.should == MARKUP
      end
    end
  end
end
