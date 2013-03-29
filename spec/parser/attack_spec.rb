require 'spec_helper.rb'
require 'travian/parser/rally_point'
require 'timecop'

module Travian::Parser
  describe Attack do
    let(:attack) { Attack.new(load_page('sample_attack_table')) }

    describe '#attrs' do
      context 'given a valid user profile' do
        subject { attack.attrs }

        it { should be_a Hash }
        it { should have_key :from_id }
        it { should have_key :to_id }
        it { should have_key :at }

      end
    end

    describe '#at' do
      context 'given an attack from Almancil to Faro at 19:44:18' do
        before :all do
          t = Time.local(2012, 9, 24, 19, 24, 41)
          Timecop.freeze(t)
        end

        after(:all) { Timecop.return }

        it 'should return a Time object' do
          attack.send(:at).should == Time.new(2012,9,24,19,44,18)
        end
      end
    end

    describe '#from_id' do
      it 'should return an id' do
        attack.send(:from_id).should == 262281
      end
    end

    describe '#to_id' do
      it 'should return an id' do
        attack.send(:to_id).should == 265492
      end
    end

    describe '#parse_time' do
      context 'given a time of the format "as 02:56:57"' do
        before :each do
          @time_string = 'as 02:56:57'
        end

        it 'returns a Time object' do
          attack.send(:parse_time, @time_string).should be_a Time
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
            attack.send(:parse_time, @time_string).should == @expected
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
            attack.send(:parse_time, @time_string).should == @expected
          end
        end
      end
    end
  end
end
