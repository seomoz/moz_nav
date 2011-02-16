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
