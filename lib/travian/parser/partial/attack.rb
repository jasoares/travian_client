require 'travian/parser/partial'

module Travian
  module Parser
    class Attack < Travian::Parser::Partial

      TIME_REGEXP = %r{.*(\d{2}):(\d{2}):(\d{2}).*}

      alias partial page

      def attrs
        {
          from_id: from_id,
          to_id: to_id,
          at: at,
        }
      end

    private

      def at
        text = partial.search('div.at span:first-child').text
        parse_time(text)
      end

      def from_id
        from['href'][/\d+\z/].to_i
      end

      def to_id
        to['href'][/\d+\z/].to_i
      end

      def from
        partial.search('td.role a').first
      end

      def to
        partial.search('td.troopHeadline a').last
      end

      def parse_time(text)
        hour, min, sec = TIME_REGEXP.match(text).captures.map(&:to_i)
        n = Time.now
        t = Time.local(n.year, n.month, n.day, hour, min, sec)
        return t.getutc if t >= n
        Time.at(t + 1.day).getutc
      end

    end
  end
end
