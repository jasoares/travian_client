require 'spec_helper.rb'
require 'travian/attack'
require 'travian/core_ext/fixnum'
require 'timecop'

module Travian
  describe Attack do
    context 'given an attack to the village Faro arriving at 02:56:47' do
      before :each do
        @from = "Almancil"
        @to = double("village", :name => "Faro", :id => 43968)
        @at = Time.new(2012, 9, 18, 2, 56, 47)
        @attack = Attack.new(@from, @to, @at)
      end

      describe '#to' do
        it 'returns the Faro village object' do
          @attack.to.should == @to
        end
      end

      describe '#at' do
        it 'returns the arrival time of the attack' do
          @attack.at.should == @at
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
            @attack.in.should be_a String
          end

          it 'should return 00:32:06' do
            @attack.in.should == "00:32:06"
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

          it 'should return "03:01:18"' do
            @attack.in.should == "03:01:18"
          end
        end
      end
    end

    describe '.parse_time' do
      context 'given a time of the format "as 02:56:57"' do
        before :each do
          @time_string = 'as 02:56:57'
        end

        it 'returns a Time object' do
          Attack.parse_time(@time_string).should be_a Time
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
            Attack.parse_time(@time_string).should == @expected
          end
        end

        context 'given the current UTC+1 time is 23:55:29 of September 17th' do
          before :all do
            t = Time.new(2012, 9, 17, 23, 55, 29)
            Timecop.freeze(t)
            @expected = Time.new(t.year, t.month, t.day + 1, 2, 56, 57)
          end

          after :all do
            Timecop.return
          end

          it 'should return 2012-09-18 02:56:57 UTC' do
            Attack.parse_time(@time_string).should == @expected
          end
        end
      end
    end

    describe '.parse_table' do
      context 'given an attack from Almancil to Faro at 19:44:18' do
        before :all do
          File.open('spec/fakeweb_pages/sample_attack_table.html') do |f|
            @sample_attack_table = Nokogiri::HTML(f)
          end
          t = Time.local(2012, 9, 24, 19, 24, 41)
          Timecop.freeze(t)
        end

        after(:all) { Timecop.return }

        it 'returns an Attack object' do
          v = double('village', :name => "Faro", :id => 43968)
          Attack.parse_table(@sample_attack_table, v).should be_an Attack
        end

        it 'should be an attack from "Almancil"' do
          v = double('village', :name => "Faro", :id => 43968)
          Attack.parse_table(@sample_attack_table, v).from.should == "Almancil"
        end

        it 'should be an attack to Faro' do
          v = double('village', :name => "Faro", :id => 43968)
          Attack.parse_table(@sample_attack_table, v).to.should == v
        end
      end
    end
  end
end
