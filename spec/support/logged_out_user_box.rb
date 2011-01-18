shared_examples_for "logged out user box" do
  {
    "Log in"  => "#",
    "Sign up" => '#',
    "Help"    => '#'
  }.each do |text, url|
    it "contains a '#{text}' link to #{url}" do
      header_nav_user_box.should have_link(text, url)
    end
  end
end
