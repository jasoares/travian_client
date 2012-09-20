module Travian
  module Helpers
    module UrlHelper
      module_function
      def base_url
        Travian.config.server
      end

      def url_for(object)
        case object
        when :villages then base_url + "/dorf3.php"
        when Village then base_url + "/dorf1.php?newdid=#{object.id}"
        end
      end
    end
  end
end
