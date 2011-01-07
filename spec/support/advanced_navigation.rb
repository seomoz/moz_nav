shared_examples_for "advanced navigation" do |options|
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  describe 'the header nav user box' do
    {
      "My Account" => "http://www.seomoz.org/users/view/#{options[:user_id]}",
      "Help"       => '#'
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_user_box.should have_link(text, url)
      end
    end
  end

  describe 'the header nav bar' do
    {
      'PRO Dashboard'  => 'http://www.seomoz.org/users/PRO',
      'Campaigns'      => '#',
      'Research Tools' => 'http://www.seomoz.org/tools',
      'Community'      => '#',
      'Learn SEO'      => 'http://www.seomoz.org/learn-seo'
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_bar.should have_link(text, url)
      end
    end
  end
end
