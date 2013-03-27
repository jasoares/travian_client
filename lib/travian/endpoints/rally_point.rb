module Travian
  module Endpoints
    module RallyPoint

      GID = 16
      MANAGEMENT = 0

      "/build.php?newdid=65506&id=39&tt=1&gid=16"

      def troop_movements(village)
        object_from_page(Travian::Parser::RallyPoint, :get, "build")
      end

    end
  end
end
