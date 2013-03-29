require 'travian/parser/base'
require 'travian/parser/partial/attack'

module Travian
  module Parser
    class RallyPoint < Travian::Parser::Base

      def attrs
        return nil unless exists?
        {
          attacks: attacks
        }
      end

    private

      def exists?
        page.search('div#overviewRallyPoint').any?
      end

      def attacks
        (in_attacks + in_raids).map do |attack|
          Attack.new(attack).attrs
        end
      end

      def in_attacks
        page.search('table.troop_details.inAttack')
      end

      def in_raids
        page.search('table.troop_details.inRaid')
      end

    end
  end
end
