module Travian
  class Tribe

    attr_reader :id, :name

    def initialize(id, name)
      @id, @name = id, name
    end

    def ==(other)
      id == other.id and name == other.name
    end

    UNKNOWN = Tribe.new(0, 'Unknown')
    ROMANS = Tribe.new(1, 'Romans')
    TEUTONS = Tribe.new(2, 'Teutons')
    GAULS = Tribe.new(3, 'Gauls')
    NATURE = Tribe.new(4, 'Nature')
    NATARS = Tribe.new(5, 'Natars')

    private_class_method :new

    class << self

      def list
        [UNKNOWN, ROMANS, TEUTONS, GAULS, NATURE, NATARS]
      end

      def [](id)
        list[id]
      end

    end
  end
end
