require 'travian/resource'
require 'travian/village'

module Travian
  class Base

    def current_village
      link = current_village_link
      Village.new(link.text, link['href'][/\d+\z/].to_i)
    end

    def villages
      villages_ids.map do |id|
        Travian.village(id)
      end
    end

    def resources
      Resource.new(*resource_data.map(&:first))
    end

    def capacity
      Resource.new(*resource_data.map(&:last))
    end

    class << self

      def from_response(response)
      end

      def parse(response)
      end

      def

    end

  end
end

