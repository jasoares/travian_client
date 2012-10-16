module Travian
  module Server
    extend self

    attr_reader :address, :status

    def initialize(address, status)
      @address, @status = address, status
    end

    class << self
      include Agent

      SERVER_REGEX = /\A\w+\.travian(?:\.\w+){1,2}?\z/

      @@servers = nil

      def servers
        unless @@servers
          page = get(:status)
          keys = page.search('tr td#link').map(&:text).reject(&:empty?).map(&:to_sym)
          @@servers = {}
          keys.each do |key|
            @@servers[key] = page.search("div##{key} td").map(&:text).select do |t|
              t.match(SERVER_REGEX)
            end.sort
          end
        end
        @@servers
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

      private

      def read_server_line(line)
        address =
        status =
        [address, status]
      end
    end
  end
end
