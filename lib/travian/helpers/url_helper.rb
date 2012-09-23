require 'travian/helpers/building_helper'
require 'travian/village'
require 'travian/building'

module Travian
  module Helpers
    module UrlHelper
      extend self
      extend BuildingHelper

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

      def url_for(target, params={})
        url = case target
        when Symbol then LINK_TO[target]
        when Building then "#{LINK_TO[:building]}?gid=#{gid_for symbol}"
        when Village then "#{LINK_TO[:resources]}?newdid=#{target.id}"
        else LINK_TO[:root]
        end
        if params.has_key? :village
          params[:village] = Travian.village(params[:village]) if params[:village].is_a? String
          url += "?newdid=#{params[:village].id}"
        end
        url
      end

      def url_for_village(village, options={})
        url = ""
        if options.include? :building
          url += "/build.php?id=#{options[:building]}&"
        elsif options.include? :section
          case options[:section]
          when :center then url += "/dorf2.php?"
          else url += "/dorf1.php?"
          end
        end
        url += "newdid=#{village.id}"
      end

      def url_for_hero(options={})
        case options[:section]
        when :inventory then "/hero_inventory.php"
        else "/hero_adventure.php"
        end
      end
    end
  end
end
