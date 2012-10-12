module Travian
  class Army
    include Enumerable

    attr_reader :troops

    def initialize(troops={})
      @troops = troops
    end

    def []=(type, amount)
      @troops[type] = amount
    end

    def [](type)
      @troops[type]
    end

    def each
      @troops.each_pair {|type, amount| yield type, amount }
    end
  end
end
