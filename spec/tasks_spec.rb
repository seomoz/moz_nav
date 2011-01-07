require 'spec_helper'

module MozNav
  describe Tasks do
    describe '.symlink_assets' do
      context 'when the ASSET_ROOT ENV var is not set' do
        before(:each) do
          ENV['ASSET_ROOT'] = nil
        end

        it "raises an error" do
          expect {
            described_class.symlink_assets
          }.to raise_error(/must set ASSET_ROOT/)
        end
      end

      context 'when the ASSET_ROOT ENV var is set' do
        around(:each) do |example|
          Dir.mktmpdir do |dir|
            ENV['ASSET_ROOT'] = dir
            example.run
          end
        end

        MozNav::AssetRoot.children(:full_path).each do |c|
          next unless c.directory?
          base = File.basename(c)

          it "symlinks the #{base} directory to the asset root" do
            described_class.symlink_assets
            host_app_path = File.join(ENV['ASSET_ROOT'], base, 'moz_nav')
            host_app_path.should be_symlinked_to(c)
          end
        end
      end
    end
  end
end
