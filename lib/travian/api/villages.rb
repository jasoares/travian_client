require 'travian/api/utils'
require 'travian/parser/village_center'
require 'travian/parser/village_fields'
require 'travian/base_village'
require 'travian/village'

module Travian
  module API
    module Villages
      include Travian::API::Utils

      def user_villages
        Travian.user.villages
      end

      alias villages user_villages

      def village_center(village=nil, options={})
        parse_response(Travian::Parser::VillageCenter, :account, :get, '/dorf2.php', options)
      end

      def village_fields(village=nil, options={})
        parse_response(Travian::Parser::VillageFields, :account, :get, '/dorf1.php', options)
      end

      def village(village=nil, options={})
        options.merge!(newdid: village) if village
        Travian::Village.new village_center(village, options).merge(village_fields(village, options))
      end

      alias current_village village

    private

      def villages_ids
        parse_response(Travian::Parser::agent.current_page).villages_ids
      end

      def reset_village
        village(start_village)
      end

    end
  end
end
