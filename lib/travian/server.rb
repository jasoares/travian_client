module Travian
  class Server

    attr_reader :region, :country, :host, :players, :start

    def initialize(region, country, host, players, start)
      @region, @country = region, country
      @host, @players, @start = host, players, start
    end

    class << self

      SERVER_REGEX = /\A\w+\.travian\.(?:\w+\.)?(\w+)\z/i
      SUBDOMAIN_REGEX = /\A(\w+)\.travian\.\w+(?:\.\w+)?\z/i
      SERVER_UP = %r{img/un/a/uparrow.gif}

      @@cache = {}

      def regions
        load_data[:regions]
      end

      def hubs(region=nil)
        return load_data[]
        regions.map {|region| load_data[:flag][:region] }
      end

      def login_available
        country_hubs.inject(0) {|sum,hub| sum += Travian.post(hub + "serverLogin.php").search('div.name').size }
      end

      def register_available
        country_hubs.inject(0) {|sum,hub| sum += Travian.post(hub + "register.php").search('div.name').size }
      end

      def full_travian_user_count
        country_hubs.inject(0) do |sum,hub|
          sum += Travian.post(hub + "serverLogin.php").search('div.player').inject(0) do |players,server_players|
            server_players.text.match(/(\d+)/); players += $1.to_i
            players
          end
          sum
        end
      end

      def login_servers
        region
        country_hubs.inject([]) do |servers, hub|
          servers += Travian.post(hub + "serverLogin.php").search('div[class~="server"]').inject([]) do |list, server_info|
            players, start = server_info.search('div')[1..2].map {|div| div.text.gsub(/[^\d]/, '').to_i }
            host = server_info.search('a.link').first['href']
            list << Server.new(host, players, start, )
          end
        end
      end

      def country_hubs(region=nil)
        return load_data[:flags].values.inject([]) {|mem,region| mem += region.values; mem } unless region
        load_data[:flags][region.to_sym].values
      end

      def country_keys(region=nil)
        return load_data[:flags].values.map(&:merge).keys unless region
        load_data[:flags][region].keys
      end

      def domains
        page = Travian.get('http://status.travian.com')
        keys = page.search('div.hidden').map {|div| div['id'].to_sym }
        keys.map {|k| page.search("div##{k.to_s} td[bgcolor]")[1].text.gsub(/.+\.travian(?:team)?\./, '') }.uniq
      end

      def all_servers
        country_hubs.map {|hub| hash[domain] = Travian.get("#{hub}serverList.php"); hash }
        (spages.merge asia_page).map {|k,v| v.search}
      end

      def keys
        servers.keys
      end

      alias :country_codes :keys

      def servers_from(code)
        servers[code]
      end

      def update!
        @@servers = nil
        servers
      end

      def count_down_servers
        list.values.inject(&:+).count {|s| s.status != 0 }
      end

      private

      def load_data
        page = Travian.get('http://www.travian.com')
        page.search('div#country_select').text.gsub(/\n|\t/, '').match(/\(({container:[^\)]+).+/)
        raw_data = jshash_to_rubyhash($1)
      end

      def jshash_to_rubyhash(str)
        eval str.gsub(/,'/, ", ").gsub(/':/, ": ").gsub(/\{'/, "{ ")
      end


      def subdomain(host)
        host.match(SUBDOMAIN_REGEX); $1
      end
    end
  end
end
