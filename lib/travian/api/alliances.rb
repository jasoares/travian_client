require 'travian/api/utils'
require 'travian/parser/alliance'
require 'travian/alliance'

module Travian
  module API
    module Alliances
      include Travian::API::Utils

      def alliance(alliance=nil, options={})
        options.merge!(aid: alliance) if alliance
        attrs = parse_response(Travian::Parser::Alliance, :account, :get, "/allianz.php", options)
        Travian::Alliance.new(attrs) if attrs
      end

    end
  end
end
