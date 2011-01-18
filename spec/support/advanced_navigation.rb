shared_examples_for "advanced navigation" do |options|
  before(:each) do
    MozNav.configure do |c|
      c.seomoz_host = SEOMOZ_HOST
    end

    visit options[:url]
  end

  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  it_behaves_like 'a cache buster'
  it_presents "a search form"

  describe 'the header' do
    it 'renders an appropriate greeting for the user' do
      header_user_greeting.text.should include("Aloha John Doe, lookin' good")
    end

    describe 'the blue box' do
      it 'renders the configured page title' do
        header_blue_box_page_title.text.should include("An Example Sinatra App")
      end

      it 'renders the configured page subtitle' do
        header_blue_box_page_subtitle.text.should include("This demonstrates how the MozNav gem works.")
      end
    end

    describe 'the user box' do
      {
        "My Account" => "http://#{SEOMOZ_HOST}/users/view/#{options[:user_id]}",
        "Help"       => '#'
      }.each do |text, url|
        it "contains a '#{text}' link to #{url}" do
          pending "In the middle of refactoring markup"
          header_nav_user_box.should have_link(text, url)
        end
      end
    end

    describe 'the nav bar' do
      {
        'PRO Dashboard'  => "http://#{SEOMOZ_HOST}/users/PRO",
        'Campaigns'      => '#',
        'Research Tools' => "http://#{SEOMOZ_HOST}/tools",
        'Q & A'          => "#",
        'Community'      => "http://#{SEOMOZ_HOST}/blog",
        'Learn SEO'      => "http://#{SEOMOZ_HOST}/learn-seo"
      }.each do |text, url|
        it "contains a '#{text}' link to #{url}" do
          header_nav_bar.should have_link(text, url)
        end
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
          'PRO Webinars'          => "http://#{SEOMOZ_HOST}/dp/PRO-webinars",
          'PRO Training DVDs'     => "http://#{SEOMOZ_HOST}/store/4",
          'PRO Training Seminars' => "http://#{SEOMOZ_HOST}/seminar/series",
          "Beginner's Guide"      => 'http://guides.seomoz.org/beginners-guide-to-search-engine-optimization',
          'Articles & Guides'     => "http://#{SEOMOZ_HOST}/learn-seo",
          'Videos'                => "http://#{SEOMOZ_HOST}/blog/category/37",
        }.each do |text, url|
          it "contains a '#{text}' link to #{url}" do
            header_sub_nav_for('learn-seo').should have_link(text, url)
          end
        end
      end
    end
  end

  describe 'the footer' do
    {
      'Campaign Manager'      => '#',
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
