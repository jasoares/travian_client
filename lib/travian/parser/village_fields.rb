require 'travian/parser/base'

module Travian
  module Parser
    class VillageFields < Travian::Parser::Base

      def attrs
        {
          name:       current_village_name,
          newdid:     current_village_id,
          resources:  resources,
          capacity:   capacity,
          production: production,
          type:       type,
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

    end
  end
end
