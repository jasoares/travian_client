module Travian
  module Parser

    def attrs
      raise NotImplementedError.new("#{self.class.name} does not support attrs")
    end

  end
end
