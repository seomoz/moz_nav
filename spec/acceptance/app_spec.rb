require 'spec_helper'

describe ExampleApp do
  it_behaves_like 'the MozNav rendering context', :campaign => true do
    let(:render_context) do
      described_class.new.tap do |c|
        c.instance_eval do
          @current_user = User.new(17, :pro)
          @current_campaign = Campaign.all.first
        end
      end
    end
  end
end
