require 'trav_wiki'

module Travian
  class Building
    attr_reader :base_building, :id, :level

    def initialize(gid, id, level)
      @base_building = TravWiki::Building[gid]
      @id, @level = id, level
    end

    private

    # Delegate to Base Building
    def method_missing(method_name, *args, &block)
      return super unless @base_building.respond_to? method_name
      @base_building.send(method_name, *args, &block)
    end
  end
end
