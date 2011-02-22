shared_examples_for "basic navigation" do
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  it_behaves_like 'a cache buster'
  it_presents "a search form"

  describe 'the header nav bar' do
    {
      'Features'        => "http://#{SEOMOZ_HOST}/pro",
      'Pricing & Plans' => "http://#{SEOMOZ_HOST}/gopro",
      'Community'       => "http://#{SEOMOZ_HOST}/community",
      'Resources'       => "http://#{SEOMOZ_HOST}/resources",
      'About'           => "http://#{SEOMOZ_HOST}/about"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_bar.should have_link(text, url)
      end
    end

    it 'has "Community" as the active nav item' do
      active_header_nav_item.text.strip.split("\n").first.strip.should == "Community"
    end
  end

  describe 'resources drop-down' do
    {
      'Learn SEO' => "http://#{SEOMOZ_HOST}/learn-seo",
      'SEO Tools' => "http://#{SEOMOZ_HOST}/tools",
      'Q&A'       => "http://#{Q_AND_A_HOST}/q"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_sub_nav_for('resources').should have_link(text, url)
      end
    end
  end
end
