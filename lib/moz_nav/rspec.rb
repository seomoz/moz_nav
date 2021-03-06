require 'rspec'

shared_examples_for 'the MozNav rendering context' do
  if defined?(RSpec)
    # only RSpec 2 allows consuming groups to override helper methods by using a block.
    def render_context
      raise NotImplementedError.new("You must define a render_context helper method for the MozNav shared example group")
    end
  end

  let(:current_user) { render_context.__send__(:current_user) }

  it 'provides a current_user' do
    current_user.should be
  end

  describe '#current_user' do
    subject { current_user }

    it { should respond_to(:pro?) }
    its(:id) { should be_an(Integer) }
    its(:display_name) { should be_a(String) }
    its(:pm_unread_count){ should be_a(Integer) }
  end
end

