require 'spec_helper'

shared_examples_for "asset symlinking" do
  subject { described_class.new(directory) }
  before(:each) { subject.symlink_assets }

  MozNav::ASSET_ROOT.children(:full_path).each do |c|
    base = File.basename(c)

    describe base do
      let(:host_app_path) { File.join(directory, base, 'moz_nav') }

      if MozNav::AssetSymlinker::EXCLUDE_ASSET_DIRS.include?(base)
        it "is not symlinked to the asset root" do
          host_app_path.should_not be_symlinked_to(c)
        end
      else
        it "is symlinked to the asset root" do
          host_app_path.should be_symlinked_to(c)
        end
      end
    end
  end
end

module MozNav
  describe AssetSymlinker do
    describe '.symlink_assets' do
      let(:tmpdir) { @tmpdir }

      around(:each) do |example|
        Dir.mktmpdir do |dir|
          @tmpdir = dir
          example.run
        end
      end

      context 'for a path that is not a valid directory' do
        subject { described_class.new(tmpdir + '/some-invalid-dir') }

        it 'raises an appropriate error' do
          expect { subject.symlink_assets }.to raise_error(ArgumentError, /is not a valid directory/)
        end
      end

      context 'for a directory without write permissions' do
        subject { described_class.new(tmpdir) }
        before(:each) { FileUtils.chmod 0000, tmpdir }
        after(:each)  { FileUtils.chmod 0777, tmpdir }

        it 'raises an appropriate error' do
          expect { subject.symlink_assets }.to raise_error(/you do not have proper file permissions/i)
        end
      end

      context 'for a directory that has not been symlinked' do
        it_performs 'asset symlinking' do
          let(:directory) { tmpdir }
        end
      end

      # the symlinking operation should be idempotent
      context 'for a directory that has already been symlinked to the correct location' do
        before(:each) do
          described_class.new(tmpdir).symlink_assets
        end

        it_performs 'asset symlinking' do
          let(:directory) { tmpdir }
        end
      end

      context 'for a directory that has previously been symlinked to a different location' do
        before(:each) do
          Dir.mktmpdir do |dir|
            described_class.new(tmpdir).instance_eval do
              MozNav::ASSET_ROOT.children(:full_path).each do |moz_nav_path|
                next unless moz_nav_path.directory?

                # symlink each to a different directory
                moz_nav_path = File.join(dir, File.basename(moz_nav_path))
                symlink_dir(moz_nav_path)
              end
            end
          end
        end

        it_performs 'asset symlinking' do
          let(:directory) { tmpdir }
        end
      end
    end
  end
end
