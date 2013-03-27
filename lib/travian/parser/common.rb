module Travian
  module Parser
    module Common

      def villages_ids
        villages_links.map do |link|
          link['href'][/\d+\z/].to_i
        end
      end

      def current_village_link
        villages_links.search('.active').first
      end

      def villages_links
        page.search('ul#villageListLinks a')
      end

      def resource_data
        page.search(".value").map do |r|
          r.text.split('/').map {|s| s.to_i }
        end.first(4)
      end

    end
  end
end
