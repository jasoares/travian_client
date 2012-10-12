module Travian
  module Countable
    def +(countable)
      self.class.new(*self.zip(countable).map {|r1, r2| r1 + r2 })
    end

    def -@
      self.class.new(*self.map{|amount| -amount })
    end

    def -(countable)
      self + (-countable)
    end

    def *(scalar)
      self.class.new(*(self.map {|amount| amount * scalar }))
    end

    def /(countable)
      self.zip(countable).map {|a1, a2| a1 / a2 }.min
    end
  end
end
