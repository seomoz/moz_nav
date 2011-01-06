require 'spec_helper'

describe "Logged in as a free user" do
  before(:each) { visit '/free_logged_in/17' }
  it_presents "basic navigation", :user_id => 17
end
