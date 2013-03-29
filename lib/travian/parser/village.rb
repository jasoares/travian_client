require 'travian/parser/base'
require 'travian/parser/partial/village_row'

module Travian
  module Parser
    class Village < Travian::Parser::Base

      def attrs
        {
          user_id: user_id,
          name: name,
          population: population,
        }
      end

    private

      def name
        page.search('h1.titleInHeader span.coordText').text
      end

      def population
        village_info[3].search('td').first.text.to_i
      end

      def user_id
        user and user['href'][/\d+\z/].to_i
      end

      def alliance_id
        alliance and alliance['href'][/\d+\z/].to_i
      end

      def user
        links = village_info[2].search('a')
        links.first unless links.empty?
      end

      def alliance
        links = village_info[1].search('a')
        links.first unless links.empty?
      end

      def village_info
        page.search('table#village_info tr')
      end

    end
  end
end
