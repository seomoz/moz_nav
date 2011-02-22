require 'spec_helper'

module MozNav
  describe PageConfig do
    describe '#active_nav_item' do
      it 'raises an error for an invalid nav item' do
        expect {
          subject.active_nav_item :foobar
        }.to raise_error(ArgumentError)
      end

      described_class::VALID_NAV_ITEM_NAMES.each do |i|
        it "does not raise an error for #{i.inspect}" do
          subject.active_nav_item i
        end
      end
    end

    describe '#nav_item_class' do
      it 'raises an error when called with an invalid nav item' do
        expect {
          subject.nav_item_class['foobar']
        }.to raise_error(ArgumentError)
      end

      described_class::VALID_NAV_ITEM_NAMES.each do |i|
        context "when called with '#{i}'" do
          it "returns '#{i} active' when it is the active item" do
            subject.active_nav_item i
            subject.nav_item_class[i.to_s].should == "#{i} active"
          end

          it "returns '#{i}' when it is not the active item" do
            other = (described_class::VALID_NAV_ITEM_NAMES - [i]).first
            subject.active_nav_item other
            subject.nav_item_class[i.to_s].should == i.to_s
          end
        end
      end
    end

    describe '#active_sub_nav_item' do
      def instance
        described_class.new.tap { |i| yield i if block_given? }
      end

      it 'returns nil when there are no sub nav items' do
        instance.active_sub_nav_item.should be_nil
      end

      it 'returns nil when there is no active sub nav item' do
        instance { |i|
          i.sub_nav_item 'Foo', 'http://foo.com/'
          i.sub_nav_item 'Bar', 'http://bar.com/'
        }.active_sub_nav_item.should be_nil
      end

      it 'returns the active sub nav item when there is one' do
        instance { |i|
          i.sub_nav_item 'Foo', 'http://foo.com/'
          i.sub_nav_item 'Bar', 'http://bar.com/', :active => true
        }.active_sub_nav_item.name.should == 'Bar'
      end

      it 'raises an error when there are multiple active sub nav items' do
        inst = instance do |i|
          i.sub_nav_item 'Foo', 'http://foo.com/', :active => true
          i.sub_nav_item 'Bar', 'http://bar.com/', :active => true
        end

        expect {
          inst.active_sub_nav_item
        }.to raise_error(/multiple active/)
      end
    end
  end
end
