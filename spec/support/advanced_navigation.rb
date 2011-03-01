shared_examples_for "advanced main nav bar" do
  describe 'the nav bar' do
    {
      'PRO Dashboard'  => "http://#{SEOMOZ_HOST}/users/pro",
      'Campaigns'      => "http://#{SEOMOZ_HOST}/campaigns",
      'Research Tools' => "http://#{SEOMOZ_HOST}/tools",
      'Q&A'            => "http://#{Q_AND_A_HOST}/q",
      'Community'      => "http://#{SEOMOZ_HOST}/community",
      'Learn SEO'      => "http://#{SEOMOZ_HOST}/learn-seo"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_bar.should have_link(text, url)
      end
    end

    it 'has "Community" as the active nav item' do
      active_header_nav_item.text.strip.split("\n").first.strip.should == "Community"
    end

    describe 'community drop-down' do
      {
        'SEO Blog'          => "http://#{SEOMOZ_HOST}/blog",
        'YOUmoz User Blog'  => "http://#{SEOMOZ_HOST}/ugc",
        'Top Users'         => "http://#{SEOMOZ_HOST}/users",
        'Events'            => "http://#{SEOMOZ_HOST}/about/events",
        'SEO Industry Jobs' => "http://#{SEOMOZ_HOST}/marketplace",
        'About SEOmoz'      => "http://#{SEOMOZ_HOST}/about",
      }.each do |text, url|
        it "contains a '#{text}' link to #{url}" do
          header_sub_nav_for('community').should have_link(text, url)
        end
      end
    end

    describe 'learn seo drop-down' do
      {
        'PRO Webinars'          => "http://#{SEOMOZ_HOST}/webinars",
        'PRO Training DVDs'     => "http://#{SEOMOZ_HOST}/store/4",
        'MozCon Seattle Seminar' => "http://#{SEOMOZ_HOST}/seminar/series",
        "Beginner's Guide"      => 'http://guides.seomoz.org/beginners-guide-to-search-engine-optimization',
        'Videos'                => "http://#{SEOMOZ_HOST}/blog/category/37",
        'Q&A'                   => "http://#{Q_AND_A_HOST}/q"
      }.each do |text, url|
        it "contains a '#{text}' link to #{url}" do
          header_sub_nav_for('learn-seo').should have_link(text, url)
        end
      end
    end
  end
end

shared_examples_for "advanced navigation footer" do
  describe 'the footer' do
    {
      'Campaign Manager'      => "http://#{SEOMOZ_HOST}/campaigns",
      'Research Tools'        => "http://#{SEOMOZ_HOST}/tools",
      'SEOmoz API'            => "http://#{SEOMOZ_HOST}/api",
      'Contact Us'            => "http://#{SEOMOZ_HOST}/about/contact",
      'Privacy Policy'        => "http://#{SEOMOZ_HOST}/pages/privacy",
      'Terms of Use'          => "http://#{SEOMOZ_HOST}/users/terms"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        footer.should have_link(text, url)
      end
    end

    describe 'social links' do
      [
        'http://feeds.feedburner.com/seomoz',
        'http://twitter.com/seomoz',
        'http://www.facebook.com/SEOmoz',
        'http://www.linkedin.com/groups?about=&gid=2976409&trk=anet_ug_grppro',
      ].each do |url|
        it "contains a link to #{url}" do
          footer_social_links.should have_link('', url)
        end
      end
    end
  end
end

shared_examples_for "campaign navigation" do |campaign|
  it_presents "the blue box header and sub nav", :campaign => campaign
end

shared_examples_for "advanced navigation" do |user_id|
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  it_behaves_like 'a cache buster'
  it_presents "a search form"
  it_presents "logged in user box", user_id
  it_presents "advanced main nav bar"
  it_presents "advanced navigation footer"
end
