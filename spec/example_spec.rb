require 'spec_helper'

describe "Example App" do
  it 'renders a page' do
    visit '/'
    page.should have_content("The page")
  end
end

