require 'spec_helper'

describe "Logged out" do
  before(:each) { visit '/logged_out' }
  it_presents "basic navigation"
end
