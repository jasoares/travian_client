module Travian
  module Configurable
    class << self

      def keys
        @keys ||= [
          :server,
          :user,
          :password
        ]
      end

    end

    attr_writer :server, :user, :password

    # Convenience method to allow configuration options to be set inside a block
    def configure
      yield self
      self
    end

    # @return [Boolean]
    def configured?
      credentials.values.all?
    end

    def [](attribute)
      self.send(attribute.to_sym)
    end

    def []=(attribute, value)
      self.send(:"#{attribute}=", value)
    end

    # @return [Fixnum]
    def cache_key
      options.hash
    end

    private

    # @return [Hash]
    def credentials
      {
        :server => @server,
        :user => @user,
        :password => @password,
      }
    end

    def options
      Hash[Travian::Configurable.keys.map {|key| [key, instance_variable_get(:"@#{key}")] } ]
    end
  end
end
