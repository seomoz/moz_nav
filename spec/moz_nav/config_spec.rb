require 'spec_helper'

module MozNav
  describe Config do
    before(:each) { MozNav::Config.reset! }

    describe '.seomoz_host' do
      it 'defaults to www.seomoz.org' do
        described_class.seomoz_host.should eql('www.seomoz.org')
      end
    end

    describe '.environment' do
      subject { described_class.environment }

      it "defaults to 'development'" do
        defined?(::Rails).should be_false
        should == 'development'
      end

      {
        'development' => %w[ development test ],
        'production'  => %w[ production staging ]
      }.each do |expected_val, rails_envs|

        it "can be manually set to '#{expected_val}'" do
          described_class.environment = expected_val
          should == expected_val
        end

        rails_envs.each do |rails_env|
          it "returns '#{expected_val}' when Rails.env is '#{rails_env}'" do
            in_sub_process {
              ENV_VAL = rails_env
              module Rails
                def self.env; ENV_VAL; end
              end

              described_class.environment
            }.should == expected_val
          end
        end
      end
    end
  end
end

