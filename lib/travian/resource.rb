module Travian
  class Resource
    include Enumerable
    include Comparable
    attr_accessor :wood, :clay, :iron, :crop

    def initialize(wood=0, clay=0, iron=0, crop=0)
      @wood, @clay, @iron, @crop = wood, clay, iron, crop
    end

    def to_a
      [@wood, @clay, @iron, @crop]
    end

    def to_s
      r = self.map {|res| res.to_s.rjust(9) }
      str = "wood: #{r[0]}|clay: #{r[1]}|iron: #{r[2]}|cereal: #{r[3]}"
      str.split('|').join(' | ')
    end

    def +(res)
      Resource.new(*self.zip(res).map {|r1, r2| r1 + r2 })
    end

    def -@
      Resource.new(*self.map{|res| -res })
    end

    def -(res)
      self + (-res)
    end

    def *(times)
      Resource.new(*(self.map {|res| res * times }))
    end

    def /(res)
      self.zip(res).map {|r1, r2| r1 / r2 }.min
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
      def parse_resources(string)
        Resource.new(*string.map {|s| s.split('/').first.to_i })
      end

      def parse_capacity(string)
        Resource.new(*string.map {|s| s.split('/').last.to_i })
      end
    end
  end
end
