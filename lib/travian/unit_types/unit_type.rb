module Travian
  class UnitType
    include Enumerable
    include Countable
    include Comparable

    attr_accessor :cost, :attack, :inf_def, :cav_def, :carry, :train_time

    def initialize(cost=nil, inf_def=0, cav_def=0, attack=0, loot=0, train_time)
      @cost = cost ? Resource.new(*cost) : Resource.new
      @attack, @inf_def, @cav_def, @carry = attack, inf_def, cav_def, carry
      @train_time = train_time
    end

    def to_s
      report =<<-END_OF_REPORT
Soldier: #{type}
Cost: #{@cost}
      END_OF_REPORT
      report
    end

    def <=>(unit)
      attack + inf_def + cav_def + carry - cost
    end

    def each
      [@cost, @attack, @inf_def, @cav_def, @carry, @train_time]
    end
  end
end