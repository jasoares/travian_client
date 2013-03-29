require 'travian/base'

module Travian
  class Alliance < Travian::Base

    attr_reader :id, :acronym, :name, :rank, :points

    alias aid id

    def ==(other)
      id == other.id
    end

  end
end
