module Travian
  module Helpers
    module BuildingHelper
      extend self

      @@bgids = nil

      def gid_for(building)
        @@bgids ||= BuildingHelper.bgids
        @@bgids[building]
      end

      def buildings
        @@bgids ||= BuildingHelper.bgids
        @@bgids.keys
      end

      def bgids
        page = Travian.get('http://answers.travian.com/index.php?aid=217')
        rows = page.search('table.tbg tr')[2..-1]
        cells = rows.search('td').map {|td| td.text }.select {|tt| tt.match(/\w+/) }
        gids_hash = Hash.new
        cells.each_slice(2) do |id, building|
          b_sym = building.gsub(' ', '_').gsub("'", '').downcase.to_sym
          gids_hash[b_sym] = id
        end
        gids_hash
      end
    end
  end
end
