require 'spec_helper.rb'
require 'travian/base_building'
require 'travian/resource'
require 'travian/timespan'

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?aid=217",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_gids.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=building&gid=16&speed=1&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_rally_point_speed1.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=building&gid=16&speed=3&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_rally_point_speed3.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=building&gid=17&speed=1&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_marketplace_speed1.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=building&gid=17&speed=3&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_marketplace_speed3.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=buildingconstructiontimes&gid=9&speed=1&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_construction_times_bakery_speed1.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=buildingconstructiontimes&gid=9&speed=3&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_construction_times_bakery_speed3.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=buildingconstructiontimes&gid=17&speed=1&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_construction_times_marketplace_speed1.html',
  :content_type => 'text/html'
)

FakeWeb.register_uri(
  :get,
  "http://t4.answers.travian.org/index.php?view=toolkit&action=buildingconstructiontimes&gid=17&speed=3&unwrapped",
  :body => './spec/fakeweb_pages/answers/t4_answers_building_construction_times_marketplace_speed3.html',
  :content_type => 'text/html'
)

module Travian
  describe BaseBuilding do
    context 'given a marketplace' do
      before :each do
        @marketplace_data = {:gid=>17, :name=>"Marketplace", :levels=>{:l1=>{:cost => Resource.new(80, 70, 120, 70), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(0,30,0), :speed3=>nil}, :culture_points=>4, :bonus=>1}, :l2=>{:cost => Resource.new(100, 90, 155, 90), :upkeep=>2, :const_time=>{:speed1=>Timespan.new(0,39,50), :speed3=>nil}, :culture_points=>4, :bonus=>2}, :l3=>{:cost => Resource.new(130, 115, 195, 115), :upkeep=>2, :const_time=>{:speed1=>Timespan.new(0,51,10), :speed3=>nil}, :culture_points=>5, :bonus=>3}, :l4=>{:cost => Resource.new(170, 145, 250, 145), :upkeep=>2, :const_time=>{:speed1=>Timespan.new(1,4,20), :speed3=>nil}, :culture_points=>6, :bonus=>4}, :l5=>{:cost => Resource.new(215, 190, 320, 190), :upkeep=>2, :const_time=>{:speed1=>Timespan.new(1,19,40), :speed3=>nil}, :culture_points=>7, :bonus=>5}, :l6=>{:cost => Resource.new(275, 240, 410,240), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(1,37,20), :speed3=>nil}, :culture_points=>9, :bonus=>6}, :l7=>{:cost => Resource.new(350, 310, 530, 310), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(1,58,0), :speed3=>nil}, :culture_points=>11, :bonus=>7}, :l8=>{:cost => Resource.new(450, 395, 675, 395), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(2,21,50), :speed3=>nil}, :culture_points=>13, :bonus=>8}, :l9=>{:cost => Resource.new(575, 505, 865, 505), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(2,49,30), :speed3=>nil}, :culture_points=>15, :bonus=>9}, :l10=>{:cost => Resource.new(740, 645, 1105, 645), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(3,21,40), :speed3=>nil}, :culture_points=>19, :bonus=>10}, :l11=>{:cost => Resource.new(945, 825, 1415, 825), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(3,59,00), :speed3=>nil}, :culture_points=>22, :bonus=>11}, :l12=>{:cost => Resource.new(1210, 1060, 1815, 1060), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(4,42,10), :speed3=>nil}, :culture_points=>27, :bonus=>12}, :l13=>{:cost => Resource.new(1545, 1355, 2320, 1355), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(5,32,20), :speed3=>nil}, :culture_points=>32, :bonus=>13}, :l14=>{:cost => Resource.new(1980, 1735, 2970, 1735), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(6,30,30), :speed3=>nil}, :culture_points=>39, :bonus=>14}, :l15=>{:cost => Resource.new(2535, 2220, 3805, 2220), :upkeep=>3, :const_time=>{:speed1=>Timespan.new(7,38,0), :speed3=>nil}, :culture_points=>46, :bonus=>15}, :l16=>{:cost => Resource.new(3245, 2840, 4870, 2840), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(8,56,20), :speed3=>nil}, :culture_points=>55, :bonus=>16}, :l17=>{:cost => Resource.new(4155, 3635, 6230, 3635), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(10,27,0), :speed3=>nil}, :culture_points=>67, :bonus=>17}, :l18=>{:cost => Resource.new(5315, 4650, 7975, 4650), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(12,12,20), :speed3=>nil}, :culture_points=>80, :bonus=>18}, :l19=>{:cost => Resource.new(6805, 5955,10210, 5955), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(14,14,30), :speed3=>nil}, :culture_points=>96, :bonus=>19}, :l20=>{:cost => Resource.new(8710, 7620,13065, 7620), :upkeep=>4, :const_time=>{:speed1=>Timespan.new(16,36,20), :speed3=>nil}, :culture_points=>115, :bonus=>20}}}
        @marketplace = BaseBuilding[:marketplace]
      end

      describe '#name' do
        it 'returns "Marketplace"' do
          @marketplace.name.should == "Marketplace"
        end
      end

      describe '#gid' do
        it 'returns 17' do
          @marketplace.gid.should be 17
        end
      end

      describe '#cost' do
        it 'should return 80, 70, 120, 70 when passed 1' do
          @marketplace.cost(1).should == @marketplace_data[:levels][:l1][:cost]
        end
      end

      describe '#max_level' do
        it 'should return 20' do
          @marketplace.max_level.should be 20
        end
      end

      describe '.const_times' do
        it 'should return a copy of the construction times hash' do
          @marketplace.const_times.should_not equal @marketplace.const_times
        end

        context 'given nothing is loaded yet' do
          before :each do
            BaseBuilding.clear_cache
            @marketplace = BaseBuilding[:marketplace]
          end
          it 'should return an empty Hash' do
            @marketplace.const_times.should == {}
          end

          it 'should change to not empty after receiving a request for a valid key' do
            filled_hash = {:speed1=>[["2:30:00", "0:30:00", "0:29:00", "0:27:50", "0:26:50", "0:25:50", "0:25:00", "0:24:00", "0:23:10", "0:22:20", "0:21:30", "0:20:50", "0:20:00", "0:19:20", "0:18:40", "0:18:00", "0:17:20", "0:16:40", "0:16:10", "0:15:30", "0:15:00"], ["3:19:00", "0:39:50", "0:38:20", "0:37:00", "0:35:40", "0:34:20", "0:33:10", "0:32:00", "0:30:50", "0:29:40", "0:28:40", "0:27:40", "0:26:40", "0:25:40", "0:24:40", "0:23:50", "0:23:00", "0:22:10", "0:21:20", "0:20:30", "0:19:50"], ["4:15:50", "0:51:10", "0:49:20", "0:47:30", "0:45:50", "0:44:10", "0:42:40", "0:41:00", "0:39:40", "0:38:10", "0:36:50", "0:35:30", "0:34:10", "0:33:00", "0:31:50", "0:30:40", "0:29:30", "0:28:30", "0:27:30", "0:26:30", "0:25:30"], ["5:21:50", "1:04:20", "1:02:00", "0:59:50", "0:57:40", "0:55:30", "0:53:30", "0:51:40", "0:49:50", "0:48:00", "0:46:20", "0:44:40", "0:43:00", "0:41:30", "0:40:00", "0:38:30", "0:37:10", "0:35:50", "0:34:30", "0:33:20", "0:32:00"], ["6:38:20", "1:19:40", "1:16:50", "1:14:00", "1:11:20", "1:08:50", "1:06:20", "1:04:00", "1:01:40", "0:59:20", "0:57:20", "0:55:10", "0:53:10", "0:51:20", "0:49:30", "0:47:40", "0:46:00", "0:44:20", "0:42:40", "0:41:10", "0:39:40"], ["8:07:00", "1:37:20", "1:33:50", "1:30:30", "1:27:20", "1:24:10", "1:21:00", "1:18:10", "1:15:20", "1:12:40", "1:10:00", "1:07:30", "1:05:00", "1:02:40", "1:00:30", "0:58:20", "0:56:10", "0:54:10", "0:52:10", "0:50:20", "0:48:30"], ["9:49:50", "1:58:00", "1:53:40", "1:49:40", "1:45:40", "1:41:50", "1:38:10", "1:34:40", "1:31:20", "1:28:00", "1:24:50", "1:21:50", "1:18:50", "1:16:00", "1:13:10", "1:10:40", "1:08:00", "1:05:40", "1:03:20", "1:01:00", "0:58:50"], ["11:49:20", "2:21:50", "2:16:40", "2:11:50", "2:07:00", "2:02:30", "1:58:10", "1:53:50", "1:49:40", "1:45:50", "1:42:00", "1:38:20", "1:34:50", "1:31:20", "1:28:00", "1:24:50", "1:21:50", "1:18:50", "1:16:00", "1:13:20", "1:10:40"], ["14:07:50", "2:49:30", "2:43:30", "2:37:30", "2:31:50", "2:26:30", "2:21:10", "2:16:00", "2:11:10", "2:06:30", "2:01:50", "1:57:30", "1:53:20", "1:49:10", "1:45:20", "1:41:30", "1:37:50", "1:34:20", "1:30:50", "1:27:40", "1:24:30"], ["16:48:20", "3:21:40", "3:14:30", "3:07:30", "3:00:40", "2:54:10", "2:47:50", "2:41:50", "2:36:00", "2:30:20", "2:25:00", "2:19:50", "2:14:40", "2:09:50", "2:05:10", "2:00:40", "1:56:20", "1:52:10", "1:48:10", "1:44:10", "1:40:30"], ["19:54:50", "3:59:00", "3:50:20", "3:42:00", "3:34:00", "3:26:20", "3:19:00", "3:11:50", "3:04:50", "2:58:10", "2:51:50", "2:45:40", "2:39:40", "2:33:50", "2:28:20", "2:23:00", "2:17:50", "2:12:50", "2:08:10", "2:03:30", "1:59:00"], ["23:30:50", "4:42:10", "4:32:00", "4:22:10", "4:12:50", "4:03:40", "3:55:00", "3:46:30", "3:38:20", "3:30:30", "3:22:50", "3:15:30", "3:08:30", "3:01:40", "2:55:10", "2:48:50", "2:42:50", "2:37:00", "2:31:20", "2:25:50", "2:20:40"], ["27:41:40", "5:32:20", "5:20:20", "5:08:50", "4:57:40", "4:47:00", "4:36:40", "4:26:40", "4:17:10", "4:07:50", "3:59:00", "3:50:20", "3:42:00", "3:34:00", "3:26:20", "3:18:50", "3:11:40", "3:04:50", "2:58:10", "2:51:50", "2:45:40"], ["32:32:30", "6:30:30", "6:16:30", "6:02:50", "5:49:50", "5:37:10", "5:25:10", "5:13:20", "5:02:10", "4:51:10", "4:40:40", "4:30:40", "4:20:50", "4:11:30", "4:02:30", "3:53:40", "3:45:20", "3:37:10", "3:29:20", "3:21:50", "3:14:30"], ["38:10:00", "7:38:00", "7:21:30", "7:05:40", "6:50:20", "6:35:30", "6:21:20", "6:07:30", "5:54:20", "5:41:30", "5:29:20", "5:17:20", "5:06:00", "4:55:00", "4:44:20", "4:34:10", "4:24:10", "4:14:40", "4:05:30", "3:56:40", "3:48:10"], ["44:41:20", "8:56:20", "8:37:00", "8:18:20", "8:00:20", "7:43:10", "7:26:30", "7:10:20", "6:54:50", "6:40:00", "6:25:30", "6:11:40", "5:58:20", "5:45:20", "5:33:00", "5:21:00", "5:09:20", "4:58:20", "4:47:30", "4:37:10", "4:27:10"], ["52:15:20", "10:27:00", "10:04:30", "9:42:40", "9:21:50", "9:01:30", "8:42:00", "8:23:10", "8:05:10", "7:47:40", "7:30:50", "7:14:40", "6:59:00", "6:43:50", "6:29:20", "6:15:20", "6:01:50", "5:48:50", "5:36:10", "5:24:10", "5:12:30"], ["61:02:00", "12:12:20", "11:46:00", "11:20:40", "10:56:10", "10:32:30", "10:09:40", "9:47:50", "9:26:40", "9:06:10", "8:46:30", "8:27:40", "8:09:20", "7:51:40", "7:34:40", "7:18:20", "7:02:30", "6:47:20", "6:32:40", "6:18:30", "6:05:00"], ["71:12:50", "14:14:30", "13:43:50", "13:14:10", "12:45:30", "12:18:00", "11:51:30", "11:25:50", "11:01:10", "10:37:20", "10:14:20", "9:52:20", "9:31:00", "9:10:20", "8:50:40", "8:31:30", "8:13:00", "7:55:20", "7:38:10", "7:21:40", "7:05:50"], ["83:01:30", "16:36:20", "16:00:30", "15:25:50", "14:52:30", "14:20:20", "13:49:30", "13:19:30", "12:50:50", "12:23:00", "11:56:20", "11:30:30", "11:05:40", "10:41:40", "10:18:30", "9:56:20", "9:34:50", "9:14:10", "8:54:10", "8:35:00", "8:16:30"]]}
            filled_hash[:speed1].map! {|row| row.map! {|col| Timespan.parse(col) } }
            expect { @marketplace.const_time(5) }.to change(@marketplace, :const_times).from({}).to(filled_hash)
          end
        end

        it 'should be a Hash' do
          @marketplace.const_times.should be_a Hash
        end
      end

      

      describe '#const_time' do
        it 'should raise LevelOutOfRange when passed 0' do
          expect {@marketplace.const_time(0)}.to raise_error BaseBuilding::LevelOutOfRange
        end

        it 'should raise LevelOutOfRange when passed 21' do
          expect {@marketplace.const_time(21)}.to raise_error BaseBuilding::LevelOutOfRange
        end

        it 'should return the total construction time in x1 when nothing passed' do
          @marketplace.const_time(:all).should == Timespan.new(107, 21, 50)
        end

        it 'should return 00:39:50 when passed 2' do
          @marketplace.const_time(2).should == Timespan.new(0, 39, 50)
        end

        it 'should return 00:39:50 when passed 2, 1, :speed1' do
          @marketplace.const_time(2, 1, :speed1).should == Timespan.new(0, 39, 50)
        end

        it 'should return 00:39:50 when passed 2, 1, :speed3' do
          @marketplace.const_time(2, 1, :speed3).should == Timespan.new(0, 13, 20)
        end
      end

      describe '#bonuses' do
        it 'should be an Array' do
          @marketplace.bonuses.should be_an Array
        end

        it 'should return a copy of the bonuses array' do
          @marketplace.bonuses.should_not equal @marketplace.bonuses
        end
      end

      describe '#upkeeps' do
        it 'should be an Array' do
          @marketplace.upkeeps.should be_an Array
        end

        it 'should return a copy of the upkeeps array' do
          @marketplace.upkeeps.should_not equal @marketplace.upkeeps
        end
      end

      describe '#costs' do
        it 'should be an Array' do
          @marketplace.costs.should be_an Array
        end

        it 'should return a copy of the costs array' do
          @marketplace.costs.should_not equal @marketplace.costs
        end
      end

      describe '#culture_points' do
        it 'should be an array' do
          @marketplace.culture_points.should be_an Array
        end

        it 'should return a copy of the culture points array when passed' do
          @marketplace.culture_points.should_not equal @marketplace.culture_points
        end
      end

      describe '#culture_points_at' do
        it 'should return the culture points produced at maximum level when nothing passed' do
          @marketplace.culture_points_at.should be 115
        end

        it 'should return the culture points produced at level 14 when passed 14' do
          @marketplace.culture_points_at(14).should be 39
        end
      end

      describe '#max_culture_points' do
        it 'should return the culture points produced at maximum level' do
          @marketplace.max_culture_points.should be 115
        end
      end
    end

    describe '.gid_for' do
      it 'returns a Fixnum' do
        BaseBuilding.gid_for(:marketplace).should be_a Fixnum
      end

      context 'when passed :marketplace' do
        it 'returns 17' do
          BaseBuilding.gid_for(:marketplace).should be 17
        end
      end

      context 'when passed :rally_point' do
        it 'returns 16' do
          BaseBuilding.gid_for(:rally_point).should be 16
        end
      end
    end

    describe '.name_for' do
      it 'returns "Marketplace" when passed :marketplace' do
        BaseBuilding.name_for(:marketplace).should == "Marketplace"
      end
    end

    describe '.table_rows_for' do
      it 'should be an array' do
        BaseBuilding.send(:table_rows_for, :marketplace).should be_an Array
      end

      it 'should return the rows from the marketplace speed 1 reference table' do
        expected = [["80", "70", "120", "70", "4", "0:30:00", "4", "1"], ["100", "90", "155", "90", "2", "0:39:50", "4", "2"], ["130", "115", "195", "115", "2", "0:51:10", "5", "3"], ["170", "145", "250", "145", "2", "1:04:20", "6", "4"], ["215", "190", "320", "190", "2", "1:19:40", "7", "5"], ["275", "240", "410", "240", "3", "1:37:20", "9", "6"], ["350", "310", "530", "310", "3", "1:58:00", "11", "7"], ["450", "395", "675", "395", "3", "2:21:50", "13", "8"], ["575", "505", "865", "505", "3", "2:49:30", "15", "9"], ["740", "645", "1105", "645", "3", "3:21:40", "19", "10"], ["945", "825", "1415", "825", "3", "3:59:00", "22", "11"], ["1210", "1060", "1815", "1060", "3", "4:42:10", "27", "12"], ["1545", "1355", "2320", "1355", "3", "5:32:20", "32", "13"], ["1980", "1735", "2970", "1735", "3", "6:30:30", "39", "14"], ["2535", "2220", "3805", "2220", "3", "7:38:00", "46", "15"], ["3245", "2840", "4870", "2840", "4", "8:56:20", "55", "16"], ["4155", "3635", "6230", "3635", "4", "10:27:00", "67", "17"], ["5315", "4650", "7975", "4650", "4", "12:12:20", "80", "18"], ["6805", "5955", "10210", "5955", "4", "14:14:30", "96", "19"], ["8710", "7620", "13065", "7620", "4", "16:36:20", "115", "20"]]
        BaseBuilding.send(:table_rows_for, :marketplace).should == expected
      end
    end      

    describe '.const_times_for' do
      it 'should return the construction times rows from the bakery on speed1 servers table when passed :bakery' do
        expected = [["5:06:40", "1:01:20", "0:59:10", "0:57:00", "0:55:00", "0:53:00", "0:51:00", "0:49:10", "0:47:30", "0:45:40", "0:44:10", "0:42:30", "0:41:00", "0:39:30", "0:38:00", "0:36:40", "0:35:20", "0:34:10", "0:32:50", "0:31:40", "0:30:30"], ["9:20:00", "1:52:00", "1:48:00", "1:44:00", "1:40:20", "1:36:40", "1:33:10", "1:29:50", "1:26:40", "1:23:30", "1:20:30", "1:17:40", "1:14:50", "1:12:10", "1:09:30", "1:07:00", "1:04:40", "1:02:20", "1:00:00", "0:57:50", "0:55:50"], ["15:40:00", "3:08:00", "3:01:10", "2:54:40", "2:48:30", "2:42:20", "2:36:30", "2:30:50", "2:25:30", "2:20:10", "2:15:10", "2:10:20", "2:05:40", "2:01:00", "1:56:40", "1:52:30", "1:48:30", "1:44:30", "1:40:50", "1:37:10", "1:33:40"], ["25:10:00", "5:02:00", "4:51:10", "4:40:40", "4:30:30", "4:20:50", "4:11:20", "4:02:20", "3:53:40", "3:45:10", "3:37:10", "3:29:20", "3:21:50", "3:14:30", "3:07:30", "3:00:50", "2:54:10", "2:48:00", "2:42:00", "2:36:10", "2:30:30"], ["39:25:00", "7:53:00", "7:36:00", "7:19:30", "7:03:40", "6:48:30", "6:33:50", "6:19:40", "6:06:00", "5:52:50", "5:40:00", "5:27:50", "5:16:00", "5:04:40", "4:53:40", "4:43:10", "4:32:50", "4:23:10", "4:13:40", "4:04:30", "3:55:40"]]
        BaseBuilding.const_times_for(:bakery).should == expected.map {|row| row.map {|timestamp| Timespan.parse(timestamp) } }
      end

      it 'should return the construction times rows from the bakery on speed3 servers table when passed :bakery, 3' do
        expected = [["1:42:10", "0:20:30", "0:19:40", "0:19:00", "0:18:20", "0:17:40", "0:17:00", "0:16:20", "0:15:50", "0:15:10", "0:14:40", "0:14:10", "0:13:40", "0:13:10", "0:12:40", "0:12:10", "0:11:50", "0:11:20", "0:11:00", "0:10:30", "0:10:10"], ["3:06:40", "0:37:20", "0:36:00", "0:34:40", "0:33:30", "0:32:10", "0:31:00", "0:30:00", "0:28:50", "0:27:50", "0:26:50", "0:25:50", "0:25:00", "0:24:00", "0:23:10", "0:22:20", "0:21:30", "0:20:50", "0:20:00", "0:19:20", "0:18:40"], ["5:13:20", "1:02:40", "1:00:20", "0:58:10", "0:56:10", "0:54:10", "0:52:10", "0:50:20", "0:48:30", "0:46:40", "0:45:00", "0:43:30", "0:41:50", "0:40:20", "0:38:50", "0:37:30", "0:36:10", "0:34:50", "0:33:40", "0:32:20", "0:31:10"], ["8:23:20", "1:40:40", "1:37:00", "1:33:30", "1:30:10", "1:27:00", "1:23:50", "1:20:50", "1:17:50", "1:15:00", "1:12:20", "1:09:50", "1:07:20", "1:04:50", "1:02:30", "1:00:20", "0:58:00", "0:56:00", "0:54:00", "0:52:00", "0:50:10"], ["13:08:20", "2:37:40", "2:32:00", "2:26:30", "2:21:10", "2:16:10", "2:11:20", "2:06:30", "2:02:00", "1:57:40", "1:53:20", "1:49:20", "1:45:20", "1:41:30", "1:37:50", "1:34:20", "1:31:00", "1:27:40", "1:24:30", "1:21:30", "1:18:30"]]
        BaseBuilding.const_times_for(:bakery, 3).should == expected.map {|row| row.map {|timestamp| Timespan.parse(timestamp) } }
      end
    end

    describe '.[]' do
      before :all do
        @all = [:woodcutter, :rally_point, :great_stable, :clay_pit, :marketplace, :city_wall, :iron_mine, :embassy, :earth_wall, :cropland, :barracks, :palisade, :sawmill, :stable, :stonemasons_lodge, :brickyard, :workshop, :brewery, :iron_foundry, :academy, :trapper, :grain_mill, :cranny, :heros_mansion, :bakery, :town_hall, :great_warehouse, :warehouse, :residence, :great_granary, :granary, :palace, :wonder_of_the_world, :smithy, :treasury, :horse_drinking_trough, :tournament_square, :trade_office, :main_building, :great_barracks]
      end

      context 'when nothing passed' do
        it 'returns an Array of all base building symbols accepted' do
          BaseBuilding[].should == @all
        end
      end

      context 'when passed some unexistent symbol like :all' do
        it 'returns an Array of all base building symbols accepted' do
          BaseBuilding[:all].should == @all
        end
      end

      context 'when passed :marketplace' do
        it 'returns a base building object' do
          BaseBuilding[:marketplace].should be_a BaseBuilding
        end
      end

      it 'should always return the same base building instance when passed the same symbol' do
        BaseBuilding[:marketplace].should equal BaseBuilding[:marketplace]
      end
    end
  end
end
