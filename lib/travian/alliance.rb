module Travian
  class Alliance

    attr_reader :id, :acronym, :name, :rank, :points

    def initialize(id, acronym, name, rank, points)
      @id, @acronym, @name, @rank, @points = id, acronym, name, rank, points
    end

    alias :aid :id

    def ==(other)
      id == other.id
    end

    class << self

      def parse(aid)
        data = Travian.get(:alliance, nil, :aid => aid).search('div#details td')
        return nil if data.empty?
        acronym, name, rank, points = data.map(&:text)[0..3]
        Alliance.new(aid, acronym, name, rank.to_i, points.to_i)
      end

    end
  end
end
