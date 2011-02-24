shared_examples_for "the blue box header and sub nav" do |*options|
  options = options.last || {}
  campaign = options[:campaign]
  user_id = options[:user_id]

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
      end
    end

    describe 'the blue box' do
      if campaign
        it "renders the campaign name (#{campaign.name})" do
          header_blue_box_page_title.text.should == campaign.name
        end

        it "renders the campaign domain host (#{campaign.domain_host})" do
          header_blue_box_page_subtitle.text.should == "<#{campaign.domain_host}>"
        end
      elsif user_id
        it 'renders the configured page title' do
          header_blue_box_page_title.text.should include("An Example <Sinatra> App")
        end
      else
        it 'does not include the blue header since there is no content for it' do
          expect { blue_header }.to raise_error(/unable to find/i)
        end
      end

      describe 'the campaigns drop down', :if => user_id do
        it "contains a 'Campaign Manager' link to http://#{SEOMOZ_HOST}/campaigns" do
          campaign_drop_down.should have_link("Campaign Manager", "http://#{SEOMOZ_HOST}/campaigns")
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
