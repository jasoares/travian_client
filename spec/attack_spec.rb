require 'spec_helper.rb'
require 'timecop'

module Travian
  describe Attack do
    context 'given an attack to the village Faro arriving at 02:56:47' do
      before :each do
        @village = Village.new('Faro', 43968)
        @arrival_time = Time.new(2012, 9, 18, 2, 56, 47)
        @attack = Attack.new(@village, @arrival_time)
      end

      describe '#target' do
        it 'returns the Faro village object' do
          @attack.target.should == @village
        end
      end

      describe '#at' do
        it 'returns the arrival time of the attack' do
          @attack.at.should == @arrival_time
        end
      end

      describe '#in' do
        context 'given the current time is 02:24:41 of September 18th' do
          before :all do
            t = Time.local(2012, 9, 18, 2, 24, 41)
            Timecop.freeze(t)
          end

          after :all do
            Timecop.return
          end

          it 'should be an integer' do
            @attack.in.should be_an Integer
          end

          it 'should be positive' do
            @attack.in.should be >= 0
          end

          it "should return #{32 * 60 + 6}" do
            @attack.in.should == 32 * 60 + 6
          end
        end

        context 'given the current time is 23:55:29 of September 17th' do
          before :all do
            t = Time.local(2012, 9, 17, 23, 55, 29)
            Timecop.freeze(t)
          end

          after :all do
            Timecop.return
          end

          it "should return #{3 * 3600 + 60 + 18}" do
            @attack.in.should == 3 * 3600 + 60 + 18
          end
        end
      end
    end

    describe '.incoming?' do
      context 'given there are incoming attacks' do
        before :each do
          FakeWeb.register_uri(
            :get,
            "http://tx3.travian.com.br/dorf3.php",
            :body => "./spec/fakeweb_pages/brx_dorf3_under_attack.html",
            :content_type => "text/html"
          )
        end

        it 'returns true' do
          Attack.incoming?.should be true
        end
      end

      context 'given there are no incoming attacks' do
        before :each do
          FakeWeb.register_uri(
            :get,
            "http://tx3.travian.com.br/dorf3.php",
            :body => "./spec/fakeweb_pages/brx_dorf3.html",
            :content_type => "text/html"
          )
        end

        it 'returns false' do
          Attack.incoming?.should be false
        end
      end
    end

    describe '.parse' do
      context 'given a time of the format "02:56:57"' do
        before :each do
          @time_string = '02:56:57'
        end

        it 'returns a Time object' do
          Attack.parse(@time_string).should be_a Time
        end

        context 'given the current time is 02:24:41 of September 18th' do
          before :all do
            t = Time.local(2012, 9, 18, 2, 24, 41)
            Timecop.freeze(t)
            @expected = Time.new(t.year, t.month, t.day, 2, 56, 57)
          end

          after :all do
            Timecop.return
          end

          it 'should return 2012-09-18 02:56:57 +0100' do
            Attack.parse(@time_string).should == @expected
          end
        end

        context 'given the current time is 23:55:29 of September 17th' do
          before :all do
            t = Time.local(2012, 9, 17, 23, 55, 29)
            Timecop.freeze(t)
            @expected = Time.new(t.year, t.month, t.day + 1, 2, 56, 57)
          end

          after :all do
            Timecop.return
          end

          it 'should return 2012-09-18 02:56:57 +0100' do
            Attack.parse(@time_string).should == @expected
          end
        end
      end
    end
  end
end

#table.troop_details.inAttack div.at span (first)

#table#overview img.att1
