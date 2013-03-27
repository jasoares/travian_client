require 'travian/timespan'
require 'travian/resource'
require 'travian/client'

module Travian
  class Village

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
      Timespan.float_hours(remaining_capacity / production)
    end

    def ==(other)
      self.id == other.id
    end

    def to_s
      "#{name}(#{id})"
    end

    class << self

      def resources_in(v)
        v = village(v) if v.is_a? String
        Resource.new(*res_data(v).map {|i| i.first })
      end

      def capacity_in(v)
        v = village(v) if v.is_a? String
        Resource.new(*res_data(v).map {|i| i.last })
      end

      def production_in(v)
        v = village(v) if v.is_a? String
        Resource.new(
          *Travian.get(:resources, v).search('#production td.num').
          text.gsub(/[^\d]+/, ' ').match(/(\d+) (\d+) (\d+) (\d+)/).captures.map {|p| p.to_i }
        )
      end

      private

      def res_data(v)
        Travian.get(:resources, v).search(".value").map do |r|
          r.text.split('/').map {|s| s.to_i }
        end.first(4)
      end
    end
  end
end
