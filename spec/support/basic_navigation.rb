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
      it "contains a '#{text}' link to #{url}" do
        header_nav_user_box.should have_link(text, url)
      end
    end
  end

  describe 'the header nav bar' do
    {
      'Features'        => 'http://www.seomoz.org/PRO',
      'Pricing & Plans' => 'http://www.seomoz.org/goPRO',
      'Community'       => 'http://www.seomoz.org/blog',
      'Learn SEO'       => 'http://www.seomoz.org/learn-seo',
      'About'           => 'http://www.seomoz.org/about'
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_bar.should have_link(text, url)
      end
    end
  end
end
