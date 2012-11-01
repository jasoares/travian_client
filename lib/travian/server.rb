module Travian
  class Server
    module Status
      extend self

      UP = 0
      DOWN = 1

      def [](id)
        case id
        when 0, true; UP
        else DOWN
        end
      end

    end

    attr_reader :host, :status

    def initialize(host, status)
      @host, @status = host, status
    end

    def to_s
      "#{host}(#{pretty_status})"
      #"#<#{self.class}:0x#{self.__id__.to_s(16)} @host=\"#{host}\", @status=\"#{pretty_status}\">"
    end

    def pretty_status
      status == 0 ? "UP" : "DOWN"
    end

    class << self

      SERVER_REGEX = /\A\w+\.travian\.(?:\w+\.)?(\w+)\z/i
      SUBDOMAIN_REGEX = /\A(\w+)\.travian\.\w+(?:\.\w+)?\z/i
      SERVER_UP = %r{img/un/a/uparrow.gif}

      @@servers = nil

      def servers
        unless @@servers
          page = Travian.get('http://status.travian.com')
          keys = page.search('div.hidden').map {|div| div['id'].to_sym }
          @@servers = {}
          keys.each do |key|
            @@servers[key] = page.search("div##{key} td").map(&:text).select do |t|
              t.match(SERVER_REGEX)
            end.sort
          end
        end
        @@servers
      end

      def list
        page = Travian.get('http://status.travian.com')
        keys = page.search('div.hidden').map {|div| div['id'].to_sym }
        keys.inject({}) do |h,k|
          h[k] = page.search("div##{k.to_s} td[bgcolor]").each_slice(2).map do |status,host|
            Server.new(
              host.text,
              status.search('img').first['src'].match(SERVER_UP) ? Status::UP : Status::DOWN
            )
          end; h
        end
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

      def subdomain(host)
        host.match(SUBDOMAIN_REGEX); $1
      end
    end
  end
end
