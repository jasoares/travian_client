module Travian
  class Village

    @@list = nil

    attr_reader :name, :id

    def initialize(name, id)
      @name, @id = name, id
    end

    class << self
      def list
        unless @@list
          villages_page = Travian.bot.get(Travian.config.server + "/dorf3.php")
          @@list = villages_page.search('td.vil.fc a').map do |village|
            id = $1.to_i if village['href'].match(/(\d+)\z/)
            Village.new(village.text, id)
          end
        end
        @@list
      end
    end
  end
end
