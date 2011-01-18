require 'spec_helper'

describe "Logged in as a free user", :type => :acceptance do
  user_id = 17
  let(:scenario_url) { "/free_logged_in/#{user_id}" }
  it_presents "basic navigation"
  it_presents "logged in user box", user_id
end
