# encoding: utf-8
require 'spec_helper.rb'

module Travian
  describe Village do
    subject { Village }

    before :all do
      FakeWeb.register_uri(
        :get,
        "http://tx3.travian.com.br/dorf3.php",
        :body => "./spec/fakeweb_pages/brx_dorf3.html",
        :content_type => "text/html"
      )
    end

    describe '#==' do
      context 'given two villages with the same name but different ids' do
        before :each do
          @village1 = Village.new('Faro', 43968)
          @village2 = Village.new('Faro', 52586)
        end

        it 'should return false' do
          (@village1 == @village2).should be false
        end
      end

      context 'given two villages with the same name and the same id' do
        before :each do
          @village1 = Village.new('Faro', 43968)
          @village2 = Village.new('Faro', 43968)
        end

        it 'should return true' do
          (@village1 == @village2).should be true
        end
      end
    end

    describe '#to_s' do
      before :each do
        @village = Village.new("Almancil", 67924)
      end

      it 'should return a string with the village\'s id and its name' do
        @village.to_s.should == "Almancil(67924)"
      end
    end

    context 'given the village Almancil with id 67924' do
      before :each do
        FakeWeb.register_uri(
          :get,
          "http://tx3.travian.com.br/dorf1.php?newdid=67924",
          :body => "./spec/fakeweb_pages/brx_dorf1_id_67924.html",
          :content_type => "text/html"
        )
        @village = Travian.village("Almancil")
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

    context 'given a village receiving 2 atacks' do
      before :all do
        FakeWeb.register_uri(
          :get,
          "http://tx3.travian.com.br/dorf3.php",
          :body => "./spec/fakeweb_pages/brx_dorf3_under_attack.html",
          :content_type => "text/html"
        )
        FakeWeb.register_uri(
          :get,
          "http://tx3.travian.com.br/dorf1.php?newdid=43968",
          :body => "./spec/fakeweb_pages/brx1_under_attack.html",
          :content_type => "text/html"
        )
        @village = Village.find_by_name("Faro")
      end
    end
  end
end
