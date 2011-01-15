shared_examples_for "basic navigation" do |options|
  before(:each) do
    MozNav.configure do |c|
      c.seomoz_host = SEOMOZ_HOST
    end

    visit options[:url]
  end

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
        pending "In the middle of refactoring markup"
        header_nav_user_box.should have_link(text, url)
      end
    end
  end

  describe 'the header nav bar' do
    {
      'Features'        => "http://#{SEOMOZ_HOST}/PRO",
      'Pricing & Plans' => "http://#{SEOMOZ_HOST}/goPRO",
      'Community'       => "http://#{SEOMOZ_HOST}/blog",
      'Learn SEO'       => "http://#{SEOMOZ_HOST}/learn-seo",
      'About'           => "http://#{SEOMOZ_HOST}/about"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        pending "In the middle of refactoring markup"
        header_nav_bar.should have_link(text, url)
      end
    end
  end
end
