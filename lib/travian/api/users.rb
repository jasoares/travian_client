require 'travian/api/utils'
require 'travian/parser/user'
require 'travian/user'

module Travian
  module API
    module Users
      include Travian::API::Utils

      def profile(user=nil, options={})
        options.merge!(uid: user) if user
        attrs = parse_response(Travian::Parser::User, :account, :get, '/spieler.php', options)
        if attrs
          return Travian::User.new(attrs) if user.nil?
          Travian::BaseUser.new(attrs)
        end
      end

      alias user profile

    end
  end
end
