require 'spec_helper'

describe "Logged out", :type => :acceptance do
  let(:scenario_url) { '/logged_out' }
  it_presents "basic navigation"
  it_presents "logged out user box"
  it_presents "the blue box header and sub nav"
end
