require 'travian/core_ext/fixnum'
require 'travian/base'

module Travian
  class Attack < Travian::Base

    attr_reader :at

    def from
      Travian.village(attrs[:from_id])
    end

    def to
      Travian.village(attrs[:to_id])
    end

    def in
      (at.utc - Time.now.utc.to_i).strftime("%T")
    end

  end
end
