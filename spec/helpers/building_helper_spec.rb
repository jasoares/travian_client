require 'spec_helper.rb'

FakeWeb.register_uri(
  :get,
  "http://answers.travian.com/index.php?aid=217",
  :body => "./spec/fakeweb_pages/answers_com_building_gids.html",
  :content_type => "text/html"
)

module Travian
  module Helpers
    describe BuildingHelper do
      describe '.bgids' do
        it 'returns a hash with symbol keys to each building and corresponding gids' do
          BuildingHelper.bgids.should be_a Hash
        end

        it 'should have keys of type Symbol only' do
          BuildingHelper.bgids.keys.all? {|k| k.is_a? Symbol }
        end

        it 'should have values of type String only' do
          BuildingHelper.bgids.values.all? {|v| v.is_a? String }
        end

        it 'should return the "21" when asked for the key :workshop' do
          BuildingHelper.bgids[:workshop].should == '21'
        end

        context 'given the data as of September 19 2012' do
          before :all do
            @bgids = {
              :woodcutter=>"1", :rally_point=>"16", :great_stable=>"30", :clay_pit=>"2",
              :marketplace=>"17", :city_wall=>"31", :iron_mine=>"3", :embassy=>"18",
              :earth_wall=>"32", :cropland=>"4", :barracks=>"19", :palisade=>"33",
              :sawmill=>"5", :stable=>"20", :stonemasons_lodge=>"34", :brickyard=>"6",
              :workshop=>"21", :brewery=>"35", :iron_foundry=>"7", :academy=>"22",
              :trapper=>"36", :grain_mill=>"8", :cranny=>"23", :heros_mansion=>"37",
              :bakery=>"9", :town_hall=>"24", :great_warehouse=>"38", :warehouse=>"10",
              :residence=>"25", :great_granary=>"39", :granary=>"11", :palace=>"26",
              :wonder_of_the_world=>"40", :smithy=>"13", :treasury=>"27",
              :horse_drinking_trough=>"41", :tournament_square=>"14", :trade_office=>"28",
              :main_building=>"15", :great_barracks=>"29"
            }
          end

          it 'should match the same gid\'s' do
            BuildingHelper.bgids.should == @bgids
          end
        end  
      end

      describe '.gid_for' do
        it 'returns "15" when passed :main_building' do
          BuildingHelper.gid_for(:main_building).should == "15"
        end

        it 'returns "4" when passed :cropland' do
          BuildingHelper.gid_for(:cropland).should == "4"
        end
      end

      describe '.buildings' do
        it 'returns an array of symbols with building names' do
          BuildingHelper.buildings.should == [
            :woodcutter, :rally_point, :great_stable, :clay_pit, :marketplace, :city_wall,
            :iron_mine, :embassy, :earth_wall, :cropland, :barracks, :palisade, :sawmill,
            :stable, :stonemasons_lodge, :brickyard, :workshop, :brewery, :iron_foundry,
            :academy, :trapper, :grain_mill, :cranny, :heros_mansion, :bakery, :town_hall,
            :great_warehouse, :warehouse, :residence, :great_granary, :granary, :palace,
            :wonder_of_the_world, :smithy, :treasury, :horse_drinking_trough, :tournament_square,
            :trade_office, :main_building, :great_barracks
          ]
        end
      end
    end
  end
end
