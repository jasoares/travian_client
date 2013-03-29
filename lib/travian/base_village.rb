require 'travian/timespan'
require 'travian/resource'
require 'travian/client'
require 'travian/base'
require 'travian/coordinates'
require 'travian/parser/village_fields'
require 'travian/parser/village_center'

module Travian
  class BaseVillage < Travian::Base
    extend Forwardable

    def_delegators :coordinates, :distance, :==, :x, :y

    attr_reader :d, :name, :capital?, :population, :coordinates

    alias id d

    def coordinates
      Travian::Coordinates.new(attrs[:coordinates][:x], attrs[:coordinates][:y])
    end

    def user
      Travian.user(attrs[:user_id])
    end

    alias coords coordinates
  end
end
