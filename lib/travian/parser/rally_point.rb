module Travian
  module Parser
    class RallyPoint < View

      def self.parse_table(table, to)
        from = table.search('td.role a').text
        at = table.search('div.at span').first.text
        Attack.new(from, to, at)
      end
      
      def attacks
        Attack.new(from, to, at)
      end

      def raids
        Attack.new(from, current, at)
      end

    private

      def attacks_data
        page.search('table.troop_details.inAttack').map do |table|
          [from(table), at(table)]
        end
      end

      def raids_data
        page.search('table.troop_details.inRaid').map do |table|
          [from(table), at(table)]
        end
      end

      def from(table)
        table.search('td.role a').text
      end

      def at(table)
        table.search('div.at span').first.text
      end

    end
  end
end
