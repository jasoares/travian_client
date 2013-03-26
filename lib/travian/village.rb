require 'yaml'
require 'travian/timespan'
require 'travian/resource'
require 'travian/client'
require 'travian/village_type'

module Travian
  class Village

    TYPES = YAML.load_file('data/t4_village_types.yml')

    attr_reader :name, :id

    def initialize(name, id)
      @name, @id = name, id
    end

    def production
      Village.production_in(self)
    end

    def buildings
      Village.buildings_of(self)
    end

    def resources
      Village.resources_in(self)
    end

    def capacity
      Village.capacity_in(self)
    end

    def type
      Village.type_of_village(self)
    end

    def percentage_filled
      resources * 100.0 / capacity
    end

    def remaining_capacity
      capacity - resources
    end

    def full_in
      Timespan.float_hours(remaining_capacity./(production, true))
    end

    def ==(other)
      self.id == other.id
    end

    def to_s
      "#{name}(#{id})"
    end

    class << self

      def types
      end

    end
  end
end
