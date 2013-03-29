require 'travian/parser/base'
require 'travian/parser/partial/coordinates'

module Travian
  module Parser
    class VillageRow < Travian::Parser::Partial

      alias partial page

      def attrs
        {
          d: map_id,
          name: name,
          capital?: capital?,
          population: population,
          coordinates: coordinates,
        }
      end

    private

      def map_id
        partial.css('td.name a').first['href'][/\d+\z/].to_i
      end

      def name
        partial.css('td.name a').text
      end

      def capital?
        partial.css('td.name span.mainVillage').any?
      end

      def population
        partial.css('td.inhabitants').text.to_i
      end

      def coordinates
        Coordinates.new(partial.css('span.coordinatesWrapper')).attrs
      end

    end

  end
end
