module Travian
  class Village
    include Helpers::UrlHelper

    attr_reader :name, :link

    def initialize(name, link)
      @name, @link = name, link
    end

    class << self
      def list
        Travian.bot.current_page.search('ul#villageListLinks a').map do |link|
          Village.new(link.text, "#{Travian.config[:server]}/dorf1.php#{link['href']}")
        end
      end
    end
  end
end
