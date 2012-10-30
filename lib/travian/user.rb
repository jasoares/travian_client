require 'travian/alliance'
require 'travian/tribe'

module Travian
  class User
    attr_reader :id, :name, :rank, :tribe, :alliance

    def initialize(uid, name, rank, tribe, alliance=nil)
      @id, @name, @rank = uid, name, rank
      @tribe = Tribe[tribe]
      @alliance = alliance
    end

    alias :uid :id

    def has_alliance?
      not @alliance.nil?
    end

    class << self

      def parse(uid)
        page = Travian.get(:user, nil, :uid => uid)
        data = page.search('table#details td')
        return nil if data.empty?
        alliance = nil
        unless page.search('table#details td')[2].text == '-'
          data.search('a[href^="allianz.php"]').first['href'].match(/allianz.php\?aid\=(\d+)/)
          alliance = Alliance.parse($1.to_i)
        end
        tribe = 0
        if uid == Travian.uid
          page.search('div.sideInfoPlayer img[class^="nationBig"]').first['class'].match(/nationBig\snationBig(\d)/)
          tribe = $1.to_i
        end
        page.search('h1.titleInHeader').first.text.match(/.+\s-\s(.+)/i)
        name = $1
        rank = data.first.text.to_i
        User.new(uid, name, rank, tribe, alliance)
      end

      def uid
        Travian.get(:resources).search('a[href^="spieler.php"]').first['href'].match(/spieler.php\?uid=(\d+)/)
        $1.to_i
      end
    end
  end
end
