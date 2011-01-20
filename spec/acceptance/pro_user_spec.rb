require 'spec_helper'

describe "Logged in as a pro user", :type => :acceptance do
  user_id = 23
  let(:scenario_url) { "/pro_logged_in/#{user_id}" }
  it_presents "advanced navigation", user_id
  it_presents "the blue box header and sub nav"

  context 'on a campaign page' do
    campaign = Campaign.all.first
    let(:scenario_url) { "/campaigns/#{campaign.id}" }
    it_presents "advanced navigation", user_id
    it_presents "campaign navigation", campaign
  end
end

