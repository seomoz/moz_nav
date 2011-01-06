shared_examples_for "basic navigation" do
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  describe 'the header nav user box' do
    {
      "Log in"  => "#",
      "Sign up" => '#',
      "Help"    => '#'
    }.each do |text, url|
      it "contains a '#{text}' link" do
        header_nav_user_box.should have_link(text, url)
      end
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
