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

RSpec::Matchers.define :be_symlinked_to do |expected_dest|
  def actual_dest
    @actual_dest ||= begin
      File.readlink(actual) if File.symlink?(actual)
    end
  end

  match do |actual|
    actual_dest.to_s == expected_dest.to_s
  end

  def failure_reason
    if actual_dest
      "was symlinked to #{actual_dest.to_s}"
    else
      "was not a symlink"
    end
  end

  failure_message_for_should do |actual|
    "expected #{actual} to be symlinked to #{expected_dest.to_s}, but #{failure_reason}"
  end
end

