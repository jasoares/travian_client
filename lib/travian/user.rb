module Travian
  class User
    attr_reader :uid, :name, :aid

    def initialize(uid, name, aid)
      @uid, @name, @aid = uid, name, aid
    end

    class << self

      def parse_profile(uid, profile)
        profile.search('#content h1.titleInHeader').first.text.match(/.+\s-\s(.+)/)
        name = $1
        profile.search('table#details a[href^="allianz.php"]').first['href'].match(/allianz.php\?(\d+)/)
        aid = $1.to_i
        User.new(uid, name, aid)
      end

    end
  end
end
