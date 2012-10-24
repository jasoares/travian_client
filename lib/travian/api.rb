require 'yaml'
require 'travian/core_ext/string'
require 'travian/village'
require 'travian/resource'
require 'travian/attack'
require 'travian/user'

module Travian
  module API
    extend self

    def villages
      get(:villages).search('td.vil.fc a').map do |village|
        id = $1.to_i if village['href'].match(/(\d+)\z/)
        Village.new(village.text, id)
      end
    end

    def user(uid=user_uid)
      User.parse_profile(uid, get(:profile, nil, :uid => uid))
    end

    def user_uid
      get(:villages).search('a[href^="spieler.php"]').first['href'].match(/spieler.php\?uid=(\d+)/)
      $1.to_i
    end

    def villages_by_name(query)
      villages.select {|v| v.name.match(/.*#{query.to_s}.*/i) }
    end

    def village(name)
      villages_by_name(name).first
    end

    def incoming_attacks?
      get(:villages).search('img.att1').any?
    end

    def attacks_to?(village)
      village = village(village) if village.is_a? String
      get(:villages).search('table#overview tr').find do |row|
        row.search('td.vil.fc a').text == village.name
      end.search('img.att1').any?
    end

    def attacks_to(village)
      village = village(village) if village.is_a? String
      page = get(:building, village, :gid => :rally_point, :tt => 1)
      attacks = page.search('table.troop_details.inAttack')
      raids = page.search('table.troop_details.inRaid')
      (attacks + raids).map {|attack| Attack.parse_table(attack, village) }
    end

    def resources_in(v)
      v = village(v) if v.is_a? String
      Resource.new(*res_data(v).map {|i| i.first })
    end

    def capacity_in(v)
      v = village(v) if v.is_a? String
      Resource.new(*res_data(v).map {|i| i.last })
    end

    def production_in(v)
      v = village(v) if v.is_a? String
      Resource.new(
        *get(:resources, v).search('#production td.num').
        text.gsub(/[^\d]+/, ' ').match(/(\d+) (\d+) (\d+) (\d+)/).captures.map {|p| p.to_i }
      )
    end

    def type_of_village(v)
      v = village(v) if v.is_a? String
      get(:resources, v).search('div#village_map').first['class'].match(/f(\d+)/)
      $1.to_i
    end

    def buildings_of(v)
      v = village(v) if v.is_a? String
      page = get :center, v
      gids = page.search('div#village_map img[class^="building g"]') + page.search('div#village_map img[class^="wall g"]')
      gids = gids.map {|img| img['class'].match(/(?:building|wall) g(\d+)/); $1.to_i }
      lvls = page.search('div#levels div[class^="aid"]').map(&:text).map(&:to_i)
      gids.zip(lvls).map.with_index do |info,idx|
        Travian::Building.new((info.first), idx + 19, info.last)
      end
    end

    def gids_of(v)
      v = village(v) if v.is_a? String
      get(:center, v).search('div#village_map img[class^="building g"]').map {|img| img['class'].match(/building g(\d+)/); $1.to_i }
    end

    def lvls_of(v)
      v = village(v) if v.is_a? String
      get(:center, v).search('div#levels div[class^="aid"]').map(&:text).map(&:to_i)
    end

    private

    def res_data(v)
      get(:resources, v).search(".value").map do |r|
        r.text.split('/').map {|s| s.to_i }
      end.first(4)
    end
  end
end
