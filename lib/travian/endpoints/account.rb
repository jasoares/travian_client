require 'travian/endpoints/utils'
require 'travian/alliance'
require 'travian/building'
require 'travian/village_fields'
require 'travian/village_center'
require 'travian/user'

module Travian
  module Endpoints
    module Account
      extend Forwardable
      include Travian::Endpoints::Utils

      def_delegators :base, :current_village, :villages

      def alliance(alliance=nil, options={})
        options.merge(aid: alliance.id) if alliance
        object_from_response(Travian::Alliance, :account, :get, "/allianz.php", options)
      end

      def building(building, village, options={})
        object_from_response(Travian::Building, :account, :get, '/build.php', options.merge(gid: building, newdid: village))
      end

      def village_center(village, options={})
        object_from_response(Travian::VillageCenter, :account, :get, '/dorf2.php', options.merge(newdid: village))
      end

      def village_fields(village, options={})
        object_from_response(Travian::VillageFields, :account, :get, '/dorf1.php', options.merge(newdid: village))
      end

      def profile(user, options={})
        object_from_response(Travian::User, :account, :get, '/spieler.php', options.merge(uid: user))
      end

      def village(village, options={})
        object_from_responses(Travian::Village, village_center(village, options), village_fields(village, options))
      end

    private

      def base
        Travian::Base.from_response(agent.current_page)
      end

      def account(request_method, path, options={})
        send(request_method.to_sym, "http://#{credentials[:server]}#{path}", options)
      end

      def login
        login_form = @agent.get("http://#{credentials[:server]}").form
        username_field = login_form.fields.find {|f| f.name = "name" }
        username_field.value = credentials[:user]
        login_form.password = credentials[:password]
        login_form.checkbox_with(:name => 'lowRes').check
        @agent.submit(login_form).search('.error.LTR').empty?
      rescue
        raise InvalidConfigurationError,
          'Invalid server address, do not include "http://"'
      end
    end
  end
end
