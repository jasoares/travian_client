require 'travian/core_ext/fixnum'
require 'travian/unit_types/unit_type'

module Travian
  module Teutons

    TEUTONS = {
      :clubswinger => {
        :cost => [95, 75, 40, 40],
        :attack => 40,
        :inf_def => 20,
        :cav_def => 5,
        :carry => 60,
        :train_time => 12.minutes
      },
      :spearman => {
        :cost => [145, 70, 85, 40],
        :attack => 10,
        :inf_def => 35,
        :cav_def => 60,
        :carry => 40,
        :train_time => 18.minutes.and(40.seconds)
      }
    }

    class Axeman < Unit
      def initialize
        super(
          [130, 120, 170, 70],
          60,
          30,
          30,
          50,
          20.minutes
        )
      end
    end

    class Scout < Unit
      def initialize
        super(
          [160, 100, 50, 50],
          0,
          10,
          5,
          0,
          18.minutes.and(40.seconds)
        )
      end
    end

    class Paladin < Unit
      def initialize
        super(
          [370, 270, 290, 75],
          55,
          100,
          40,
          110,
          40.minutes
        )
      end
    end

    class TeutonicKnight < Unit
      def initialize
        super(
          [450, 515, 480, 80],
          150,
          50,
          75,
          80,
          49.minutes.and(20.seconds)
        )
      end
    end

    class Ram < Unit
      def initialize
        super(
          [1000, 300, 350, 70],
          65,
          30,
          80,
          0,
          1.hour.and(10.minutes)
        )
      end
    end

    class Catapult < Unit
      def initialize
        super(
          [900, 1200, 600, 60],
          50,
          60,
          10,
          0,
          2.hours.and(30.minutes)
        )
      end
    end

    class Chief < Unit
      def initialize
        super(
          [35500, 26600, 25000, 27200],
          40,
          60,
          40,
          0,
          19.hours.and(35.minutes)
        )
      end
    end

    class Settler < Unit
      def initialize
        super(
          [5800, 4400, 4600, 5200],
          10,
          80,
          80,
          3000,
          8.hours.and(36.minutes).and(40.seconds)
        )
      end
    end

    def all
  end
end
