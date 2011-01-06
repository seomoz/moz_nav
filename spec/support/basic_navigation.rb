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

  describe 'the header nav bar' do
    it 'contains the expected top-level items' do
      header_nav_bar_items.map(&:text).should == [
        'Features',
        'Pricing & Plans',
        'Community',
        'Learn SEO',
        'About'
      ]
    end
  end
end
