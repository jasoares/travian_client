require 'travian/core_ext/string'
require 'travian/timespan'
require 'travian/resource'
require 'travian/agent'

module Travian
  class BaseBuilding

    class LevelOutOfRange < ArgumentError; end

    attr_reader :symbol, :name, :gid

    def initialize(building)
      @symbol = building
      @gid, @name = BaseBuilding.cache[building][:gid], BaseBuilding.cache[building][:name]
      @costs, @upkeeps, @culture_points, @bonuses = BaseBuilding.data_for(building)
      @const_times = Hash.new { |hash, key| hash[key] = BaseBuilding.const_times_for(building, key.to_s[-1].to_i) }
    end

    alias :to_i :gid
    alias :id :gid

    def cost(level=max_level)
      raise LevelOutOfRange if level < 1 || level > max_level
      costs[level - 1]
    end

    def culture_points
      Array.new(@culture_points)
    end

    def culture_points_at(level=max_level)
      raise LevelOutOfRange if level < 1 || level > max_level
      @culture_points[level - 1]
    end

    alias :max_culture_points :culture_points_at

    def max_level
      @costs.size
    end

    def const_time(level, mb_level=1, speed=:speed1)
      return @const_times[speed].map {|t| t[mb_level] }.inject(:+) if level.nil? || level == :all
      raise LevelOutOfRange if level < 1 || level > max_level
      Timespan.new(@const_times[speed][level - 1][mb_level].to_i)
    end
    alias :const_time_for :const_time

    alias :to_sym :symbol

    def const_times
      Hash[@const_times]
    end

    def bonuses
      Array.new(@bonuses)
    end

    def upkeeps
      Array.new(@upkeeps)
    end

    def costs
      Array.new(@costs)
    end

    def to_a
      [costs, upkeeps, const_times, culture_points, bonuses]
    end

    class << self
      include Agent

      @@cache = {}

      def cache
        if @@cache.empty?
          page = get('http://t4.answers.travian.org/index.php?aid=217')
          rows = page.search('table.tbg tr')[2..-1]
          cells = rows.search('td').map {|td| td.text }.select {|tt| tt.match(/\w+/) }
          cells.each_slice(2) do |gid, name|
            @@cache[name.symbolize] = {
              :name => name,
              :gid => gid.to_i
            }
          end
        end
        @@cache
      end

      def keys
        cache.keys
      end

      def clear_cache
        @@cache = {}
      end

      def by_gid(gid)
        cache.find {|k,v| v[:gid] == gid }
      end

      def gid_for(building)
        cache[building][:gid]
      end

      def name_for(building)
        return cache.each_pair.find {|k,v| v[:gid] == building }[1][:name] if building.is_a? Fixnum
        cache[building][:name]
      end

      def [](building=:all)
        return by_gid(building) if building.is_a? Fixnum
        return cache[building][:info] ||= BaseBuilding.new(building) if cache.key?(building)
        keys
      end

      def data_for(building)
        data = table_rows_for building
        costs, upkeeps, culture_points, bonuses = [], [], [], []
        data.each do |row|
          costs << Resource.new(*row[0..3].map(&:to_i))
          upkeeps << row[4].to_i
          culture_points << row[6].to_i
          bonuses << (row[7] ? row[7].to_i : nil)
        end
        [costs, upkeeps, culture_points, bonuses]
      end

      def table_rows_for(building)
        page = get(:building => building)
        page.search('table tbody tr').map {|l| l.search('td')[1..-1].map(&:text) }
      end

      def const_times_for(building, speed=1)
        get(:const_times => building, :speed => speed).search('tbody tr').map do |row|
          row.search('td').map {|td| Timespan.parse(td.text) }
        end
      end
    end
  end
end
