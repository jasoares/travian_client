module Travian
  class Base

    def self.attr_reader(*attrs)
      mod = Module.new do
        attrs.each do |attribute|
          define_method attribute do
            @attrs[attribute.to_sym]
          end
          define_method "#{attribute}?" do
            !!@attrs[attribute.to_sym]
          end
        end
      end
      const_set(:Attributes, mod)
      include mod
    end

    def initialize(attrs={})
      @attrs = attrs
    end

    def [](method)
      send(method.to_sym)
    rescue NoMethodError
      nil
    end

    def attrs
      @attrs
    end

    alias to_hash attrs

  end
end

