require 'spec_helper'

describe ExampleApp do
  it_behaves_like 'the MozNav rendering context' do
    let(:render_context) do
      described_class.new.tap do |c|
        c.instance_eval { @current_user = User.new(17, :pro) }
      end
    end
  end
end
