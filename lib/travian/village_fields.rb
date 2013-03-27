require 'travian/base'

module Travian
  class VillageFields < Travian::Base

    def name
      current_village_link.text
    end

    def id
      current_village_link['href'][/\d+\z/].to_i
    end

  end
end
