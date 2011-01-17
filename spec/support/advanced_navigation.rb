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

  describe 'the header' do
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
        'Community'      => '#',
        'Learn SEO'      => "http://#{SEOMOZ_HOST}/learn-seo"
      }.each do |text, url|
        it "contains a '#{text}' link to #{url}" do
          pending "In the middle of refactoring markup"
          header_nav_bar.should have_link(text, url)
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
