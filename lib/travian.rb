require 'travian/configurable'
require 'travian/client'

module Travian
  class << self
    include Configurable

    private

    def client
      @client = Client.new(options) unless defined?(@client) && @client.cache_key == options.hash
      @client
    end

    # Delegate to current Travian::Client
    # @return [Travian::Client]
    def method_missing(method_name, *args, &block)
      return super unless client.respond_to? method_name
      client.send(method_name, *args, &block)
    end
  end
end
