require 'spec_helper'

module MozNav
  describe PageConfig do
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
