require 'active_support/core_ext/hash/slice'

module Travian

  class VillageType

    [:lumber, :clay, :iron, :crop].each do |attr|
      define_method(:"#{attr}_fields") { instance_variable_get("@#{attr.to_s}") }
    end

    def initialize(options={})
      @lumber, @clay, @iron, @crop = options.slice('lumber', 'clay', 'iron', 'crop').values

    end

    def method_missing(method_name, *args, &block)
      return super unless client.respond_to? method_name
      client.send(method_name, *args, &block)
    end

    class << self

      def types
        types = YAML.load_file('data/t4_village_types.yml')
        types.values.map { |type| VillageType.new(type) }
      end

    end
  end

end