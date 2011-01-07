shared_examples_for "advanced navigation" do |options|
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  describe 'the header nav user box' do
    {
      "My Account" => "http://www.seomoz.org/users/view/#{options[:user_id]}",
      "Help"       => '#'
    }.each do |text, url|
      it "contains a '#{text}' link" do
        header_nav_user_box.should have_link(text, url)
      end
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
