module Travian
  module API
    module Users

      def user_by_id(id)
        User.parse(id)
      end

      def user
        User.parse(uid)
      end

      def uid
        get(:resources).search('a[href^="spieler.php"]').first['href'].match(/spieler.php\?uid=(\d+)/)
        $1.to_i
      end

      alias user_id uid

    end
  end
end
