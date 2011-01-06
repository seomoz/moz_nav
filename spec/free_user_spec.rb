require 'spec_helper'

describe "Logged in as a free user" do
  before(:each) { visit '/free_logged_in' }
  it_presents "basic navigation"
end
