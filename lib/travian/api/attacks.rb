require 'travian/parser/rally_point'
require 'travian/attack'

module Travian
  module API
    module Attacks

      def attacks(village, options={})
        options.merge!(newdid: village)
        attrs = parse_response(Travian::Parser::RallyPoint, :account, :get, '/build.php?id=39', options)
        attrs[:attacks].map do |attrs|
          Travian::Attack.new(attrs)
        end
      end

    end
  end
end
