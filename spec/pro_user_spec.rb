require 'spec_helper'

describe "Logged in as a pro user" do
  before(:each) { visit '/pro_logged_in/23' }
  it_presents "advanced navigation", :user_id => 23
end

