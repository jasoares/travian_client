module Travian
  module API
    module Villages

      def villages
        get(:villages).search('td.vil.fc a').map do |village|
          id = $1.to_i if village['href'].match(/(\d+)\z/)
          Village.new(village.text, id)
        end
      end

      def villages_by_name(query)
        villages.select {|v| v.name.match(/.*#{query.to_s}.*/i) }
      end

      def village_by_name(name)
        villages_by_name(name).first
      end

      alias village village_by_name

      def reset_village
        get(:resources, :village => village(start_village))
        start_village
      end

    end
  end
end
