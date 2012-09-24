require 'travian/village'
require 'travian/resource'

module Travian
  module API
    def villages
      get(:villages).search('td.vil.fc a').map do |village|
        id = $1.to_i if village['href'].match(/(\d+)\z/)
        Village.new(village.text, id)
      end
    end

    def villages_by_name(query)
      villages.select {|v| v.name.match(/.*#{query}.*/i) }
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

    private

    def res_data(v)
      get(:resources, v).search(".value").map do |r|
        r.text.split('/').map {|s| s.to_i }
      end.first(4)
    end
  end
end
