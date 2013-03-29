module Travian
  class Coordinates

    attr_reader :x, :y

    def initialize(x, y)
      @x, @y = x, y
    end

    def ==(other)
      self.x == other.x && self.y == other.y
    end

    def distance(other)
      raise ArgumentError unless other.respond_to?(:x) and other.respond_to?(:y)
      Math.sqrt((x - other.x)**2 + (y - other. y)**2)
    end

    def to_s
      "(#{x}|#{y})"
    end

    def hash
      v = 17
      v = 37 * v + x.hash
      v = 37 * v + y.hash
      v
    end

  end
end
