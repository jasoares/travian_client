require 'travian/parser/base'
require 'travian/parser/partial/village_row'

module Travian
  module Parser
    class User < Travian::Parser::Base

      def attrs
        return nil unless exists?
        {
          id: profile_id,
          name: profile_name,
          rank: rank,
          tribe: tribe,
          alliance_id: alliance_id,
          population: population,
          logged_user?: logged_user?,
          villages: villages,
        }
      end

    private

      def exists?
        page.search('table#details').any?
      end

      def logged_user?
        page.search('div.contentNavi.subNavi').any?
      end

      def profile_id
        return user_id if logged_user?
        link = page.search('table#details a.message').first
        link ? link['href'][/\d+\z/].to_i : nil
      end

      def profile_name
        return user_name if logged_user?
        page.search('h1.titleInHeader').first.text[/\w+\z/]
      end

      def rank
        user_details[0].text.to_i
      end

      def tribe
        user_details[1].text
      end

      def alliance_id
        return nil unless user_details[2].css('a').any?
        user_details[2].css('a').first['href'][/\d+\z/].to_i
      end

      def population
        user_details[4].text.to_i
      end

      def user_details
        data = page.search('table#details td')
        data.empty? ? [nil] * 5 : data[0..4]
      end

      def villages
        return outside_villages_info unless logged_user?
        outside_villages_info.map do |village|
          village[:newdid] = user_village_id(village[:name])
          village
        end
      end

      def outside_villages_info
        villages = page.search('table#villages tbody tr')
        villages.map { |v| VillageRow.new(v).attrs }
      end

      def user_village_id(name)
        v = villages_ids.zip(villages_names).find { |vid, vname| vname == name }
        v and v.first
      end

    end
  end
end
