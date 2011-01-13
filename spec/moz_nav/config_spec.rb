require 'spec_helper'

module MozNav
  describe Config do
    describe '.seomoz_host' do
      it 'defaults to www.seomoz.org' do
        MozNav::Config.reset!
        MozNav::Config.seomoz_host.should eql('www.seomoz.org')
      end
    end
  end
end

