module Travian

  @@config = Configuration.new

  class << self

    def configure
      yield @@config
      return @@config
    end

    def config
      @@config
    end
  end
end
