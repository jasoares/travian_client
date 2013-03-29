require 'travian/api/utils'
require 'travian/parser/building'
require 'travian/building'

module Travian
  module API
    module Buildings
      include Travian::API::Utils

      def building(building, village=nil, options={})
        options.merge!(newdid: village) if village
        attrs = parse_response(Travian::Parser::Building, :account, :get, '/build.php', options.merge(gid: building))
        Travian::Building.new(attrs) if attrs
      end

    end
  end
end
