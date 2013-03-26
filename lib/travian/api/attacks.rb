module Travian
  module API
    module Attacks

      def incoming_attacks?
        get(:villages).search('img.att1').any?
      end

      def attacks_to?(village)
        village = village(village) if village.is_a? String
        get(:villages).search('table#overview tr').find do |row|
          row.search('td.vil.fc a').text == village.name
        end.search('img.att1').any?
      end

      def attacks_to(village)
        village = village(village) if village.is_a? String
        page = get(:building, village, :gid => :rally_point, :tt => 1)
        attacks = page.search('table.troop_details.inAttack')
        raids = page.search('table.troop_details.inRaid')
        (attacks + raids).map {|attack| Attack.parse_table(attack, village) }
      end

    end
  end
end
