shared_examples_for "advanced navigation" do |options|
  before(:each) do
    MozNav.configure do |c|
      c.seomoz_host = SEOMOZ_HOST
    end

    visit options[:url]
  end

  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  describe 'the header nav user box' do
    {
      "My Account" => "http://#{SEOMOZ_HOST}/users/view/#{options[:user_id]}",
      "Help"       => '#'
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        pending "In the middle of refactoring markup"
        header_nav_user_box.should have_link(text, url)
      end
    end
  end

  describe 'the header nav bar' do
    {
      'PRO Dashboard'  => "http://#{SEOMOZ_HOST}/users/PRO",
      'Campaigns'      => '#',
      'Research Tools' => "http://#{SEOMOZ_HOST}/tools",
      'Community'      => '#',
      'Learn SEO'      => "http://#{SEOMOZ_HOST}/learn-seo"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        pending "In the middle of refactoring markup"
        header_nav_bar.should have_link(text, url)
      end
    end
  end
end
