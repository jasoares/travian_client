require 'travian/core_ext/fixnum'

module Travian
  class Timespan
    include Comparable

    TIME_REGEXP = %r{[^\d]*(\d+):(\d{2}):(\d{2}).*}

    ARGS = [:weeks, :days, :hours, :minutes, :seconds]

    # Convenience argument structure to allow one to write one of the following:
    # Timespan.new(12, 5, 15)
    # Timespan.new(12.hours + 5.minutes.and(15.seconds))
    # Timespan.new(12.hours + 5.minutes + 5.seconds)
    def initialize(*args)
      args = Timespan.parse_string(args.first) if args.first.is_a? String
      @time = args.zip(ARGS.last(args.size)).inject(0) {|time, t| time += t.first.send(t.last) }
    end

    def +(other)
      return Time.at(other + self.to_i) if other.is_a? Time
      Timespan.new(@time + other.to_i)
    end

    def -(other)
      Timespan.new(self.to_i - other.to_i)
    end

    def coerce(other)
      [self, other]
    end

    def /(scalar)
      Timespan.new(self.to_i / scalar)
    end

    def *(scalar)
      Timespan.new(self.to_i * scalar)
    end

    def to_i
      @time
    end
    alias :to_int :to_i

    def hours
      (@time / 3600).abs
    end

    def minutes
      @time % 3600 / 60
    end

    def seconds
      @time % 3600 % 60
    end

    def round_to(precision)
      res = @time % precision < precision / 2 ? @time : @time + precision
      res -= @time % precision
      Timespan.new(res.to_i)
    end

    def past?
      @time < 0
    end
    alias :negative? :past?

    def to_s
      (past? ? "-" : "") + [hours, minutes, seconds].map {|v| v.to_s.rjust(2, "0") }.join(":")
    end

    def <=>(other)
      @time <=> other.to_i
    end

    def self.parse(timestamp)
      Timespan.new(*parse_string(timestamp))
    end

    def self.float_hours(time)
      fh = time
      h = time.to_i
      fm = (fh - h) * 60
      m = fm.to_i
      fs = (fm - m) * 60
      s = fs.to_i
      Timespan.new(h.hours + m.minutes + s.seconds)
    end

    private

    def self.parse_string(timestamp)
      timestamp.match(TIME_REGEXP).captures.map(&:to_i)
    end
  end
end
