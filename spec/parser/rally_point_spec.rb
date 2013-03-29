require 'spec_helper.rb'
require 'timecop'

module Travian::Parser
  describe RallyPoint do
    let(:rally_point) { RallyPoint.new(load_page('brx_rally_point_under_raid_and_attack')) }

    describe '#attacks' do
      it 'returns an array' do
        rally_point.send(:attacks).should be_an Array
      end

      it 'should have 3 attacks' do
        rally_point.send(:attacks).should have(3).attacks
      end
    end
  end
end