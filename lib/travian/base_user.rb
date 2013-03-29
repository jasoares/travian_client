require 'travian/base'
require 'travian/alliance'
require 'travian/tribe'
require 'travian/base_village'
require 'travian/village'

module Travian
  class BaseUser < Travian::Base
    attr_reader :id, :name, :rank, :tribe, :alliance_id, :population, :logged_user?

    alias :uid :id

    def has_alliance?
      !!alliance_id
    end

    def alliance
      Travian.alliance(alliance_id) unless alliance_id.zero?
    end

    def villages
      attrs[:villages].map do |v|
        if logged_user?
          inside_info = Travian.user_village(v[:newdid])
          Travian::Village.new(v.merge(inside_info))
        else
          Travian::BaseVillage.new(v)
        end
      end
    end

    def villages_count
      attrs[:villages].size
    end

  end
end