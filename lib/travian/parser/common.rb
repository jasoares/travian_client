module Travian
  module Parser
    module Common

      def user_data
        page.search('a.signLink').first
      end

      def user_id
        user_data['href'][/\d+\z/].to_i
      end

      def user_name
        user_data.text[/\w+/]
      end

      def user_tribe_id
        img = page.search('div.sideInfoPlayer img[class^="nationBig"]').first
        img['class'][/\d\z/].to_i
      end

      def user_alliance?
        page.search('div.sideInfoAlly').any?
      end

      def resource_data
        page.search(".value").map do |r|
          r.text.split('/').map(&:to_i)
        end.first(4)
      end

      def current_village_link
        villages_links.search('.active').first
      end

      def villages_links
        page.search('ul#villageListLinks a')
      end

      def villages_ids
        villages_links.map do |link|
          link['href'].match(/newdid=(\d+)/); $1.to_i
        end
      end

      def villages_names
        villages_links.map(&:text)
      end

      def current_village_name
        current_village_link.text
      end

      def current_village_id
        current_village_link['href'][/\d+\z/].to_i
      end

    end
  end
end
