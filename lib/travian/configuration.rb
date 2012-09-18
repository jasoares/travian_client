module Travian
  class Configuration

    attr_reader :server
    attr_accessor :user, :password

    def initialize(server='tx3.travian.com.br', user='user', password='password')
      @server = "http://#{server}"
      @user, @password = user, password
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
