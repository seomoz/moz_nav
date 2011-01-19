require 'spec_helper'

describe MozNav do
  describe '.configure' do
    it 'yields the configuration object' do
      expect {
        described_class.configure do |c|
          c.seomoz_host = 'seomoz.local:3000'
        end
      }.to change { MozNav::Config.seomoz_host }.to('seomoz.local:3000')
    end
  end

  describe '.ensure_assets_symlinked_from' do
    it 'ensures the assets are symlinked using AssetSymlinker' do
      symlinker = mock('asset symlinker', :symlink_assets => nil)
      MozNav::AssetSymlinker.should_receive(:new).with('my_dir').and_return(symlinker)

      described_class.ensure_assets_symlinked_from('my_dir')
    end
  end
end
