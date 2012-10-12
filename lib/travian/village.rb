require 'travian/resource'

module Travian
  class Village

    attr_reader :name, :id

    def initialize(name, id)
      @name, @id = name, id
    end

    def production
      Travian.production_in(self)
    end

    def buildings
      Travian.buildings_of(self)
    end

    def resources
      Travian.resources_in(self)
    end

    def capacity
      Travian.capacity_in(self)
    end

    def type
      Travian.type_of_village(self)
    end

    def percentage_filled
      resources * 100.0 / capacity
    end

    def ==(other)
      self.id == other.id
    end

    def to_s
      "#{name}(#{id})"
    end
  end
end
