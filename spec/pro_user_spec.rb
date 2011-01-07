require 'spec_helper'

describe "Logged in as a pro user" do
  it_presents "advanced navigation", :user_id => 23, :url => '/pro_logged_in/23'
end

