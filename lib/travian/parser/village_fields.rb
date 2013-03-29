require 'travian/parser/base'

module Travian
  module Parser
    class VillageFields < Travian::Parser::Base

      def attrs
        {
          user_id:    user_id,
          name:       current_village_name,
          newdid:     current_village_id,
          resources:  resources,
          capacity:   capacity,
          production: production,
          type:       type,
          incoming_attacks_count: incoming_attacks_count,
        }
      end

    private

      def resources
        resource_data.map(&:first)
      end

      def capacity
        resource_data.map(&:last)
      end

      def production
        text = page.search('#production td.num').text
        text.gsub(/[^-\d]+/, ' ').strip.split(' ').map(&:to_i)
      end

      def type
        page.search('div#village_map').first['class'][/\d+/].to_i
      end

      def incoming_attacks_count
        a1 = page.search('table#movements tr:nth-child(2) span.a1')
        a1.any? ? a1.first.text[/\d+/].to_i : 0
      end

    end
  end
end
