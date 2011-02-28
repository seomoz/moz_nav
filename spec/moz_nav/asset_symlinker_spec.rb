require 'spec_helper'

shared_examples_for "asset symlinking" do
  subject { described_class.new(directory) }
  before(:each) { subject.symlink_assets }
  let(:host_app_path) { File.join(directory, "moz_nav_assets") }

  it 'symlinks the asset root to "moz_nav_assets" in the host app' do
    host_app_path.should be_symlinked_to(MozNav::ASSET_ROOT)
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
        around(:each) do |example|
          Dir.mktmpdir do |dir|
            described_class.new(tmpdir).instance_eval do
              symlink_dir(dir)
            end

            example.run
          end
        end

        it_performs 'asset symlinking' do
          let(:directory) { tmpdir }
        end
      end
    end
  end
end
