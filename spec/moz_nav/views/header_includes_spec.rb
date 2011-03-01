require 'spec_helper'

module MozNav
  module Views
    describe HeaderIncludes do
      let(:result) { described_class.render }

      it 'renders with no errors' do
        result
      end

      %w[development production].each do |env|
        context "when environment is set to '#{env}'" do
          before(:each) { MozNav.configure { |c| c.environment = env } }

          it "uses the #{env} stylesheet" do
            result.should =~ %r|moz_nav_assets/stylesheets/#{env}/all\.css|
          end
        end
      end
    end
  end
end
