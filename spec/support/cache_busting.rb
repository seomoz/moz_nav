RSpec::Matchers.define :use_cache_buster do
  def cache_buster
    "?#{MozNav::VERSION}"
  end

  def paths
    @paths ||= actual.map(&:text)
  end

  def non_cache_busted_paths
    @non_cache_busted_paths ||= paths.reject { |p| p.end_with?(cache_buster) }
  end

  match do |actual|
    non_cache_busted_paths.empty?
  end

  failure_message_for_should do |actual|
    (
      ["expected all elements to use the cache buster (#{cache_buster}).  The following did not:"] +
      non_cache_busted_paths
    ).join("\n  ")
  end
end

shared_examples_for 'a cache buster' do
  it 'uses the cache buster for image elements' do
    page.all(:xpath, '//img/@src').should use_cache_buster
  end

  it 'uses the cache buster for javascript files (except jquery)' do
    page.all(:xpath, '//script/@src').reject { |s| s.text =~ /jquery/ }.should use_cache_buster
  end

  it 'uses the cache buster for stylesheets' do
    page.all(:xpath, "//link[@rel='stylesheet']/@href").should use_cache_buster
  end
end
