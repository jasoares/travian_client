require 'travian/core_ext/fixnum'

module Travian
  class Attack

    TIME_REGEXP = %r{.*(\d{2}):(\d{2}):(\d{2}).*}
    attr_reader :from, :to, :at

    def initialize(from, to, at)
      at = Attack.parse_time(at) if at.is_a? String
      @from, @to, @at = from, to, at
    end

    def in
      (at.utc - Time.now.utc.to_i).strftime("%T")
    end

    protected

    def self.parse_time(arrival_time)
      hour, min, sec = TIME_REGEXP.match(arrival_time).captures.map(&:to_i)
      n = Time.now
      t = Time.local(n.year, n.month, n.day, hour, min, sec)
      return t.getutc if t >= n
      Time.at(t + 1.day).getutc
    end

    def self.parse_table(table, to)
      from = table.search('td.role a').text
      at = table.search('div.at span').first.text
      Attack.new(from, to, at)
    end
  end
end
