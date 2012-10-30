require 'spec_helper.rb'

module Travian
  describe Tribe do
    describe '.[]' do
      it 'should return TEUTONS when passed 2' do
        Tribe[2].should == Tribe::TEUTONS
      end
    end

    describe '.list' do
      it 'should return a list of all the tribes' do
        Tribe.list.should have_exactly(6).tribes
      end
    end
  end
end
