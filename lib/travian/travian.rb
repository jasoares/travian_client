module Travian

  @@config = Configuration.new

  class << self

    def configure
      yield @@config
      return @@config
    end
  end
end
