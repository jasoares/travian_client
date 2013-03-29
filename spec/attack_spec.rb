require 'spec_helper.rb'
require 'travian/attack'
require 'travian/core_ext/fixnum'
require 'timecop'

module Travian
  describe Attack do
    context 'given an attack to the village Faro arriving at 02:56:47' do
      let(:attrs) do
        { from_id: 43968, to_id: 311903, at: Time.new(2012, 9, 18, 2, 56, 47) }
      end

      let(:attack) { Attack.new(attrs) }

      describe '#at' do
        it 'returns the arrival time of the attack' do
          attack.at.should == Time.new(2012, 9, 18, 2, 56, 47)
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
            attack.in.should be_a String
          end

          it 'should return 00:32:06' do
            attack.in.should == "00:32:06"
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
            attack.in.should == "03:01:18"
          end
        end
      end
    end
  end
end
