module Travian
  class User
    attr_reader :uid, :name, :alliance

    def initialize(uid, name, alliance)
      @uid, @name, @alliance = uid, name, alliance
    end

    class << self

      def parse_profile(uid, profile)
        profile.search('#content h1.titleInHeader').first.text.match(/.+\s-\s(.+)/)
        name = $1
        alliance = profile.search('table#details a[href^="allianz.php"]').first.text
        User.new(uid, name, alliance)
      end

    end
  end
end
