require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br/dorf3.php",
  :body => "./spec/fakeweb_pages/brx_dorf3.html",
  :content_type => "text/html"
)

FakeWeb.register_uri(
  :get,
  "http://tx3.travian.com.br/dorf1.php?newdid=67924",
  :body => "./spec/fakeweb_pages/brx_dorf1_id_67924.html",
  :content_type => "text/html"
)

module Travian
  describe Village do
    subject { Village }

    describe '.list' do
      it 'returns an array' do
        Village.list.should be_an Array
      end

      it 'should be an array with village objects' do
        Village.list.all? {|v| v.is_a? Village }.should be true
      end
    end

    context 'given the village Almancil with id 67924' do
      before :each do
        @village = Village.list.first
      end

      describe '#name' do
        it 'should return "Almancil"' do
          @village.name.should == "Almancil"
        end
      end

      describe '#id' do
        it 'should return 67924' do
          @village.id.should == 67924
        end
      end

      describe '#production' do
        context 'given the current production is 5625, 2813, 3750, 5528' do
          before :all do
            @production = Resource.new(5625, 2813, 3750, 5528)
          end

          it 'should be a Resource' do
            @village.production.should be_a Resource
          end

          it 'should return Resource.new(5625, 2813, 3750, 5528)' do
            @village.production.should == @production
          end
        end
      end

      describe '#resources' do
        context 'given the current amount of resources is 12245, 3216, 6044, 13036' do
          before :all do
            @resources = Resource.new(12245, 3216, 6044, 13036)
          end

          it 'should be a Resource' do
            @village.resources.should be_a Resource
          end

          it 'should return Resource.new(12245, 3216, 6044, 13036)' do
            @village.resources.should == @resources
          end
        end
      end

      describe '#capacity' do
        context 'given the current capacity is 55100, 55100, 55100, 55100' do
          before :all do
            @capacity = Resource.new(55100, 55100, 55100, 55100)
          end

          it 'should be a Resource' do
            @village.capacity.should be_a Resource
          end

          it 'should return Resource.new(55100, 55100, 55100, 55100)' do
            @village.capacity.should == @capacity
          end
        end
      end
    end
  end
end
