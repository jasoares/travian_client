require 'travian/resource'
require 'travian/village'

module Travian
  class View

    attr_reader :page

    def initialize(page)
      @page = page
    end

    def current_village
      link = current_village_link
      Village.new(link.text, link['href'][/\d+\z/].to_i)
    end

    def villages
      villages_links.map do |a|
        Village.new(a.text, a['href'][/\d+\z/].to_i)
      end
    end

    def resources
      Resource.new(*resource_data.map(&:first))
    end

    def capacity
      Resource.new(*resource_data.map(&:last))
    end

  private

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
