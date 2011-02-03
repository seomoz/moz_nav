shared_examples_for "basic navigation" do
  it "has valid xhtml" do
    page.body.should be_xhtml_strict
  end

  it_behaves_like 'a cache buster'
  it_presents "a search form"

  describe 'the header nav bar' do
    {
      'Features'        => "http://#{SEOMOZ_HOST}/pro",
      'Pricing & Plans' => "http://#{SEOMOZ_HOST}/gopro",
      'Community'       => "http://#{SEOMOZ_HOST}/community",
      'Resources'       => "http://#{SEOMOZ_HOST}/resources",
      'About'           => "http://#{SEOMOZ_HOST}/about"
    }.each do |text, url|
      it "contains a '#{text}' link to #{url}" do
        header_nav_bar.should have_link(text, url)
      end
    end
  end
end
