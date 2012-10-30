require 'yaml'
require 'travian/core_ext/string'
require 'travian/village'
require 'travian/resource'
require 'travian/attack'
require 'travian/user'

module Travian
  module API
    extend self

    v_types = YAML.load_file('data/t4_village_types.yml')
    v_types.each_pair do |type, desc|
      desc.each_pair do |k,v|
        v_types[type][k] = case v
          when 'woodcutter' then 1
          when 'clay pit' then 2
          when 'iron mine' then 3
          when 'cropland' then 4
        end
      end unless desc[1].nil?
    end

    V_TYPES = v_types

    def villages
      get(:villages).search('td.vil.fc a').map do |village|
        id = $1.to_i if village['href'].match(/(\d+)\z/)
        Village.new(village.text, id)
      end
    end

    def user(uid=uid)
      User.parse(uid)
    end

    def uid
      User.uid
    end

    alias :user_id :uid

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

    def village_types
      V_TYPES
    end

    def resource_fields(v)
      v = village(v) if v.is_a? String
      type_data = V_TYPES[type_of_village(v)]
      lvls = get(:resources, v).search('div.level').map(&:text).map(&:to_i)
      1.upto(18).map do |id|
        Travian::Building.new(type_data[id], id, lvls[id - 1])
      end
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
