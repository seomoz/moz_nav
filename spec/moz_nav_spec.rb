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
end
