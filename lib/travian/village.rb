module Travian
  class Village < TravianObject

    attr_reader :name, :id

    def initialize(name, id)
      @name, @id = name, id
    end

    def production
      Village.production(self)
    end

    def resources
      Village.resources(self)
    end

    def capacity
      Village.capacity(self)
    end

    def ==(other)
      self.id == other.id
    end

    def to_s
      "#{name}(#{id})"
    end

    class << self

      @@list = nil

      def list
        unless @@list
          villages_page = Travian.bot.get(url_for(:villages))
          @@list = villages_page.search('td.vil.fc a').map do |village|
            id = $1.to_i if village['href'].match(/(\d+)\z/)
            Village.new(village.text, id)
          end
        end
        @@list
      end

      def by_name(name)
        @@list ||= list
        @@list.select {|v| v.name.match(/.*#{name}.*/i) }
      end

      def production(village)
        values = page(village).search('#production td.num').text.gsub(/[^\d]+/, ' ')
        res = values.match(/(\d+) (\d+) (\d+) (\d+)/).captures.map {|v| v.to_i }
        Resource.new(*res)
      end

      def resources(village)
        Resource.parse_resources(res_data(village))
      end

      def capacity(village)
        Resource.parse_capacity(res_data(village))
      end

      private

      def res_data(village)
        1.upto(4).map.with_index do |idx|
          page(village).search("span#l#{idx}.value").text
        end
      end

      def page(village)
        Travian.bot.get(url_for(village))
      end
    end
  end
end
