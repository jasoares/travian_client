module Travian
  class Configuration

    attr_reader :server
    attr_accessor :user, :password

    def initialize
      @server = 'http://server.travian.com'
      @user = 'username'
      @password = 'password'
    end

    def [](attribute)
      self.send(attribute.to_sym)
    end

    def []=(attribute, value)
      self.send(:"#{attribute}=", value)
    end

    def server=(address)
      @server = "http://#{address}"
    end

    def attributes
      [:server, :user, :password]
    end

    alias :keys :attributes
  end
end
