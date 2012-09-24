# encoding: utf-8
require 'spec_helper.rb'

module Travian
  describe API do
    describe '.villages' do
      it 'returns an array' do
        Travian.villages.should be_an Array
      end

      it 'should be an array with village objects' do
        Travian.villages.all? {|v| v.is_a? Village }.should be true
      end
    end

    describe '.village' do
      it 'should return a village' do
        Travian.village("al").should be_a Village
      end
    end

    describe '.villages_by_name' do
      context 'when passed "al" as the search term' do
        before :all do
          @villages = [
            Village.new('Almancil', 67924),
            Village.new('São Brás de Alportel', 59519),
          ]
        end

        it 'should have exactly 2 villages' do
          Travian.villages_by_name("al").should have_exactly(2).villages
        end

        it 'should find "Almancil" and "São Brás de Alportel"' do
          Travian.villages_by_name("al").should == @villages
        end
      end
    end

    describe '.incoming_attacks?' do
      context 'given there are incoming attacks' do
        before(:all) { fake_incoming_attacks }

        it 'returns true' do
          Travian.incoming_attacks?.should be true
        end
      end

      context 'given there are no incoming attacks' do
        before(:all) { fake_no_incoming_attacks }

        it 'returns false' do
          Travian.incoming_attacks?.should be false
        end
      end
    end

    describe '.attacks_to?' do
      context 'given there are no incoming attacks' do
        before(:all) { fake_no_incoming_attacks }

        it 'returns false' do
          Travian.attacks_to?("Faro").should == false
        end
      end

      context 'given there are incoming attacks only to Faro' do
        before(:all) { fake_incoming_attacks }

        it 'returns true when passed "Faro"' do
          Travian.attacks_to?("Faro").should == true
        end

        it 'returns false when passed "Almancil"' do
          Travian.attacks_to?("Almancil").should == false
        end
      end
    end
  end
end
