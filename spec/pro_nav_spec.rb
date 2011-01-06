require 'spec_helper'

describe "Logged in as a pro user" do
  before(:each) { visit '/pro_logged_in' }
  it_presents "advanced navigation"
end

