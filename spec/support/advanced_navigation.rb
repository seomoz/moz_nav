shared_examples_for "advanced main nav bar" do
  describe 'the nav bar' do
    {
      'PRO Dashboard'  => "http://#{SEOMOZ_HOST}/users/pro",
      'Campaigns'      => '#',
      'Research Tools' => "http://#{SEOMOZ_HOST}/tools",
      'Q&A'          => "#",
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

shared_examples_for "the blue box header and sub nav" do |*options|
  options = options.last || {}
  campaign = options[:campaign]

  describe 'the header' do
    describe 'the sub nav bar' do
      if campaign
        {
          'Campaign'          => "/campaigns/#{campaign.id}",
          'Rankings'          => "/campaigns/#{campaign.id}/rankings",
          'Issues'            => "/campaigns/#{campaign.id}/issues",
        }.each do |text, url|
          it "contains a '#{text}' link to #{url}" do
            header_sub_nav_bar.should have_link(text, url)
          end
        end

        it 'sets "Issues" to the active sub nav item' do
          active_header_sub_nav_item.text.strip.should == 'Issues'
        end

        describe 'the "Issues" sub sub nav bar' do
          {
            'Overview'  => "/campaigns/#{campaign.id}/issues/overview",
            'Summary'   => "/campaigns/#{campaign.id}/issues/summary",
            'Dashboard' => "/campaigns/#{campaign.id}/issues/dashboard"
          }.each do |text, url|
            it "contains a '#{text}' link to #{url}" do
              header_sub_sub_nav_bar.should have_link(text, url)
            end
          end
        end
      else
        it 'renders an appropriate greeting for the user' do
          header_user_welcome_bar.text.should include("Aloha John Doe, lookin' good")
        end
      end
    end

    describe 'the blue box' do
      if campaign
        it "renders the campaign name (#{campaign.name})" do
          header_blue_box_page_title.text.should == campaign.name
        end

        it "renders the campaign domain host (#{campaign.domain_host})" do
          header_blue_box_page_subtitle.text.should == campaign.domain_host
        end
      else
        it 'renders the configured page title' do
          header_blue_box_page_title.text.should include("An Example Sinatra App")
        end

        it 'renders the configured page subtitle' do
          header_blue_box_page_subtitle.text.should include("This demonstrates how the MozNav gem works.")
        end
      end

      describe 'the campaigns drop down' do
        it "contains a 'Campaign Manager' link to #" do
          campaign_drop_down.should have_link("Campaign Manager", "#")
        end

        Campaign.all.each do |camp|
          path = "/campaigns/#{camp.id}"
          it "contains a '#{camp.name}' link to #{path}" do
            campaign_drop_down.should have_link(camp.name, path)
          end
        end
      end
    end
  end
end

shared_examples_for "advanced navigation footer" do
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
