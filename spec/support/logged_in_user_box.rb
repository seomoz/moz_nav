shared_examples_for "logged in user box" do |user_id|
  {
    "My Account" => "http://#{SEOMOZ_HOST}/users/view/#{user_id}",
    "Help"       => "http://#{SEOMOZ_HOST}/about/contact"
  }.each do |text, url|
    it "contains a '#{text}' link to #{url}" do
      header_nav_user_box.should have_link(text, url)
    end
  end
end

