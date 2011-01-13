require 'spec_helper'

module MozNav
  module Views
    describe HeaderIncludes do
      it 'renders with no errors' do
        described_class.render
      end
    end
  end
end
