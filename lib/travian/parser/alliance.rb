require 'travian/parser/base'

module Travian
  module Parser
    class Alliance < Travian::Parser::Base

      def attrs
        return nil unless exists?
        {
          acronym: alliance_data[0],
          name:    alliance_data[1],
          rank:    alliance_data[2].to_i,
          points:  alliance_data[3].to_i,
        }
      end

    private

      def exists?
        page.search('div#details').any?
      end

      def alliance_data
        data = page.search('div#details td')
        data.empty? ? [nil] * 4 : data.map(&:text)[0..3]
      end

    end
  end
end
