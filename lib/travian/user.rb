require 'travian/base'
require 'travian/base_user'
require 'travian/alliance'
require 'travian/tribe'

module Travian
  class User < Travian::BaseUser

    def incoming_attacks?
      villages.any?(&:incoming_attacks?)
    end

    def villages_under_attack
      villages.select(&:incoming_attacks?)
    end

  end

  Account = User
end
