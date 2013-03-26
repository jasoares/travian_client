require 'travian/resource'
require 'travian/building'
require 'travian/village'

module Travian
  module Parser
    class Fields < Travian::View

      def production
        Resource.new(*production_data)
      end

      def type
        page.search('div#village_map').first['class'][/\d+/].to_i
      end

      def resource_fields
        Travian::Building.new

    private

      def production_data
        text = page.search('#production td.num').text
        text.gsub(/[^\d]+/, ' ').strip.split(' ').map(&:to_i)
      end

    end
  end
end
