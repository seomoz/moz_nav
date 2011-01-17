shared_examples_for "a search form" do
  it 'submits to the correct URL' do
    header_search_form['action'].should == "http://#{SEOMOZ_HOST}/pages/search_results"
  end

  it 'submits as a GET' do
    header_search_form['method'].should == 'get'
  end

  it 'has a text box with the correct input name' do
    header_search_form.find(:xpath, "//input[@type='text']")['name'].should == 'q'
  end
end
