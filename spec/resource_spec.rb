require 'spec_helper.rb'

module Travian
  describe Resource do
    context 'given a resource of 120 wood, 180 clay, 232 iron and 412 cereal' do
      before :each do
        @res = Resource.new(120, 180, 232, 412)
      end

      describe '#wood' do
        it 'should return 120' do
          @res.wood.should == 120
        end
      end

      describe '#clay' do
        it 'should return 180' do
          @res.clay.should == 180
        end
      end

      describe '#iron' do
        it 'should return 232' do
          @res.iron.should == 232
        end
      end

      describe '#crop' do
        it 'should return 412' do
          @res.crop.should == 412
        end
      end

      describe '#to_a' do
        it 'returns an array of each resource in the order [wood, clay, iron, crop]' do
          @res.to_a.should == [@res.wood, @res.clay, @res.iron, @res.crop]
        end
      end

      describe '#to_s' do
        it 'should return a string representation of the resource' do
          string = "wood:       120 | clay:       180 | iron:       232 | cereal:       412"
          @res.to_s.should == string
        end

        it 'should return a string representation for values up to 999.999.999' do
          res = Resource.new(999999999, 999999999, 999999999, 999999999)
          string = "wood: 999999999 | clay: 999999999 | iron: 999999999 | cereal: 999999999"
          res.to_s.should == string
        end
      end  

      describe '#eql?' do
        it 'should return true when all types are equal in value' do
          res = Resource.new(120, 180, 232, 412)
          @res.eql?(res).should be true
        end

        it 'should return false when any type is different in value' do
          res = Resource.new(121, 180, 232, 412)
          @res.eql?(res).should be false
        end
      end

      describe '#-@' do
        it 'should return a new negative resource' do
          (-@res).should == Resource.new(-120, -180, -232, -412)
        end
      end

      describe '#*' do
        it 'returns a new resource with each type multiplied by the value passed' do
          (@res * 3).should == Resource.new(360, 540, 696, 1236)
        end
      end

      describe '#/' do
        it 'returns the lowest division result with the fractional part of dividing each type of resource' do
          res = Resource.new(90, 50, 70, 40)
          (@res / res).should be_within(0.0001).of(1.3333)
        end
      end

      describe '#<=>' do
        context 'when compared to 120 wood, 180 clay, 232 iron and 412 crop' do
          it 'should return 0' do
            res = Resource.new(120, 180, 232, 412)
            (@res <=> res).should be 0
          end
        end

        context 'when compared to 130 wood, 170 clay, 232 iron and 412 crop' do
          it 'should return -1' do
            res = Resource.new(130, 170, 232, 412)
            (@res <=> res).should be -1
          end
        end

        context 'when compared to 130 wood, 190 clay, 242 iron and 411 crop' do
          it 'should return -1' do
            res = Resource.new(130, 190, 242, 411)
            (@res <=> res).should be -1
          end
        end

        context 'when compared to 130 wood, 200 clay, 303 iron and 456 crop' do
          it 'should return 1' do
            res = Resource.new(130, 200, 303, 456)
            (@res <=> res).should be 1
          end
        end
      end

      context 'given another resource of 390 wood, 450 clay, 340 iron and 190 crop' do
        before :each do
          @res2 = Resource.new(390, 450, 340, 190)
        end

        describe '#+' do
          it 'should return a new resource with the sum of the two' do
            (@res + @res2).should == Resource.new(510, 630, 572, 602)
          end
        end

        describe '#-' do
          it 'should return a new resource with the result of the subtraction' do
            (@res2 - @res).should == Resource.new(270, 270, 108, -222)
          end
        end
      end
    end
  end
end
