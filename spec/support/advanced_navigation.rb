shared_examples_for "advanced navigation" do
  describe 'the header nav user box' do
    it 'contains the expected items' do
      header_nav_user_box_items.map(&:text).should == [
        'My Account',
        'Help'
      ]
    end
  end

  describe 'the header nav bar' do
    it 'contains the expected top-level items' do
      header_nav_bar_items.map(&:text).should == [
        'PRO Dashboard',
        'Campaigns',
        'Research Tools',
        'Community',
        'Learn SEO'
      ]
    end
  end
end
