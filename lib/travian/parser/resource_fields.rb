require 'travian/resource'
require 'travian/village'

module Travian
  module Parser
    class ResourceFields < Travian::View

      def production
        Resource.new(*production_data)
      end

      def incoming_attacks_count
        text = page.search('table#movements tr:nth-child(2) span.a1')
        text.any? ? text.first.text[/\d+/].to_i : 0
      end

      def next_incoming_attack
        return nil if incoming_attacks_count == 0
        timer1 = page.search('span#timer1')
        timer1.any? ? timer1.first.text : nil
      end

    private

      def production_data
        text = page.search('#production td.num').text
        text.gsub(/[^\d]+/, ' ').strip.split(' ').map(&:to_i)
      end
    end
  end
end
