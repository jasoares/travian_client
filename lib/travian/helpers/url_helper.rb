require 'travian/helpers/building_helper'
require 'travian/village'
require 'travian/building'

module Travian
  module Helpers
    module UrlHelper
      extend self

      private

      LINK_TO = {
        :root       => '/',
        :resources  => '/dorf1.php',
        :center     => '/dorf2.php',
        :statistics => '/statistiken.php',
        :reports    => '/berichte.php',
        :messages   => '/nachrichten.php',
        :map        => '/karte.php',
        :villages   => '/dorf3.php',
        :building   => '/build.php',
      }

      module_function

      def url_for(page, village=nil, params={})
        url = LINK_TO[page]
        url += "?newdid=#{village.id}" if village
        if params.size > 0
          url += "&" if village
          url += "?" unless village
        end
        url += params.each_pair.map do |k,v|
          k == :gid ? "#{k}=#{BuildingHelper.gid_for(v)}" : "#{k}=#{v}"
        end.join("&")
      end
    end
  end
end
