RSpec::Matchers.define :have_link do |text, url|
  define_method :link do
    begin
      actual.find_link(text)
    rescue Capybara::ElementNotFound
      nil
    end
  end

  def actual_html
    actual.native.inner_html
  end

  match do |actual|
    link && link['href'] == url
  end

  failure_message_for_should do |actual|
    "expected element to have a '#{text}' link to #{url}.\nElement HTML:\n#{actual_html}"
  end
end

