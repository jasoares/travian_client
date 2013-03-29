require 'travian/parser/partial'

module Travian
  module Parser
    class Coordinates < Travian::Parser::Partial

      alias partial page

      def attrs
        { x: x, y: y }
      end

    private

      def x
        partial.css('span.coordinateX').text[/[-\d]+/].to_i
      end

      def y
        partial.css('span.coordinateY').text[/[-\d]+/].to_i
      end

    end
  end
end
