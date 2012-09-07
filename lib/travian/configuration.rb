module Travian
  class Configuration

    attr_accessor :server, :user, :password

    def initialize
      @server = 'server.travian.com'
      @user = 'username'
      @password = 'password'
    end

    def [](attribute)
      self.send(attribute.to_sym)
    end

    def []=(attribute, value)
      self.send(:"#{attribute}=", value)
    end

    def attributes
      [:server, :user, :password]
    end

    alias :keys :attributes
  end
end
