require 'spec_helper'

describe "Logged in as a free user" do
  it_presents "basic navigation", :user_id => 17, :url => '/free_logged_in/17'
end
