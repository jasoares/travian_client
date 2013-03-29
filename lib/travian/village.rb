require 'travian/timespan'
require 'travian/resource'
require 'travian/base_village'

module Travian
  class Village < Travian::BaseVillage

    attr_reader :newdid, :incoming_attacks_count

    alias id newdid

    def production
      Resource.new(*attrs[:production])
    end

    def resources
      Resource.new(*attrs[:resources])
    end

    def capacity
      Resource.new(*attrs[:capacity])
    end

    def buildings
      Village.buildings_of(self)
    end

    def cereal_dropping?
      production.cereal < 0
    end

    def type
      attrs[:type]
    end

    def percentage_filled
      resources % capacity
    end

    def remaining_capacity
      capacity - resources
    end

    def incoming_attacks?
      incoming_attacks_count > 0
    end

    def attacks
      Travian.attacks(self) if incoming_attacks?
    end

    def full_in
      rem_cap = remaining_capacity
      rem_cap.crop = resources.crop
      Timespan.float_hours(rem_cap / production.abs)
    end

    def starving_in
      return nil unless cereal_dropping?
      Timespan.float_hours(resources.cereal.to_f / production.cereal.abs)
    end

  end
end
