shared_examples_for "basic navigation" do
  describe 'the header nav user box' do
    it 'contains the expected items' do
      header_nav_user_box_items.map(&:text).should == [
        'Log in',
        'Sign up',
        'Help'
      ]
    end
  end
end
