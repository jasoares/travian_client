require 'travian/countable'

module Travian
  class Resource
    include Enumerable
    include Comparable
    include Countable
    attr_accessor :wood, :clay, :iron, :crop

    def initialize(wood=0, clay=0, iron=0, crop=0)
      @wood, @clay, @iron, @crop = wood, clay, iron, crop
    end

    def to_a
      [@wood, @clay, @iron, @crop]
    end

    def to_s
      r = self.map {|res| res.to_s.rjust(9) }
      "wood: #{r[0]} | clay: #{r[1]} | iron: #{r[2]} | cereal: #{r[3]}"
    end

    def <=>(res)
      side_by_side = self.zip(res)
      return -1 if side_by_side.any? {|res1, res2| res1 > res2 }
      return 0 if side_by_side.all? {|res1, res2| res1 == res2 }
      return 1
    end

    def eql?(res)
      self == res
    end

    def hash
      v = 17
      v = 37 * v + @wood.hash
      v = 37 * v + @clay.hash
      v = 37 * v + @iron.hash
      v = 37 * v + @crop.hash
      v
    end

    def each
      to_a.each {|res| yield res }
    end

    class << self

      def [](wood=0, clay=0, iron=0, crop=0)
        Resource.new(wood, clay, iron, crop)
      end

      def parse_resources(res_data)
        Resource[*res_data.map {|s| s.split('/').first.to_i }]
      end

      def parse_capacity(res_data)
        Resource[*res_data.map {|s| s.split('/').last.to_i }]
      end

    end
  end
end
