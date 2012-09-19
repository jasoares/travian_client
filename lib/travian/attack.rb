module Travian
  class Attack

    TIME_REGEXP = %r{\A(\d{2}):(\d{2}):(\d{2})\z}
    attr_reader :target, :at

    def initialize(target, at)
      at = Attack.parse(at) if at.is_a? String
      @target, @at = target, at
    end

    def in
      (at - Time.now).ceil
    end

    protected

    def self.parse(arrival_time)
      hour, min, sec = TIME_REGEXP.match(arrival_time).captures.map(&:to_i)
      n = Time.now
      t = Time.local(n.year, n.month, n.day, hour, min, sec)
      return t if t >= n
      Time.at(t + 24 * 3600)
    end

    class << self
      def incoming?
        villages_page = Travian.bot.get(Travian.config.server + "/dorf3.php")
        return !villages_page.search('table#overview img.att1').empty?
      end
    end
  end
end
