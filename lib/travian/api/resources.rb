module Travian
  module API
    module Resources

      def resources_in(v)
        v = village(v) if v.is_a? String
        Resource.new(*res_data(v).map {|i| i.first })
      end

      def type_of_village(v)
        v = village(v) if v.is_a? String
        get(:resources, v).search('div#village_map').first['class'].match(/f(\d+)/)
        $1.to_i
      end

    private

      def res_data(v)
        get(:resources, v).search(".value").map do |r|
          r.text.split('/').map {|s| s.to_i }
        end.first(4)
      end

    end
  end
end
