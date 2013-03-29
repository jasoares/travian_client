# encoding: utf-8
require 'spec_helper.rb'

module Travian
  describe Village do
    context 'given the village Almancil with id 67924' do
      describe '#name' do
        let(:village) { Village.new(name: 'Almancil') }

        it 'should return "Almancil"' do
          village.name.should == "Almancil"
        end
      end

      describe '#id' do
        let(:village) { Village.new(newdid: 67924) }

        it 'should return 67924' do
          village.id.should == 67924
        end
      end

      describe '#production' do
        context 'given the current production is 5625, 2813, 3750, 5528' do
          let(:production) { Resource.new(5625, 2813, 3750, 5528) }
          let(:village) { Village.new(production: [5625, 2813, 3750, 5528]) }

          it 'should be a Resource' do
            village.production.should be_a Resource
          end

          it 'should return Resource.new(5625, 2813, 3750, 5528)' do
            village.production.should == production
          end
        end
      end

      describe '#resources' do
        context 'given the current amount of resources is 12245, 3216, 6044, 13036' do
          let(:resources) { Resource.new(12245, 3216, 6044, 13036) }
          let(:village) { Village.new(resources: [12245, 3216, 6044, 13036]) }

          it 'should be a Resource' do
            village.resources.should be_a Resource
          end

          it 'should return Resource.new(12245, 3216, 6044, 13036)' do
            village.resources.should == resources
          end
        end
      end

      describe '#capacity' do
        context 'given the current capacity is 55100, 55100, 55100, 55100' do
          let(:capacity) { Resource.new(55100, 55100, 55100, 55100) }
          let(:village) { Village.new(capacity: [55100, 55100, 55100, 55100]) }

          it 'should be a Resource' do
            village.capacity.should be_a Resource
          end

          it 'should return Resource.new(55100, 55100, 55100, 55100)' do
            village.capacity.should == capacity
          end
        end
      end
    end
  end
end
