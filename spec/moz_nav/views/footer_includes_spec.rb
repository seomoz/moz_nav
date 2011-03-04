require 'spec_helper'

module MozNav
  module Views
    describe FooterIncludes do
      it 'renders with no errors' do
        described_class.render
      end

      it 'does not include jquery by default' do
        described_class.render.should_not =~ /jquery[^'"]+js['"]/i
      end

      it 'includes jquery when rendered with :jquery => true' do
        described_class.new(:jquery => true).render.should =~ /jquery[^'"]+js['"]/i
      end
    end
  end
end

