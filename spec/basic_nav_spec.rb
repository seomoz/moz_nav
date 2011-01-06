require 'spec_helper'

describe "Logged out Navigation" do
  before(:each) { visit '/logged_out' }

  describe 'the header nav user box' do
    it 'contains the expected items' do
      header_nav_user_box_items.map(&:text).should == [
        'Log in',
        'Sign up',
        'Help'
      ]
    end
  end
end
