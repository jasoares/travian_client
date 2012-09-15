module Travian
  module Helpers
    module UrlHelper
      def method_missing(meth, *args, &block)
        meth.to_s.match(/\A\w+_url\z/) ? url_helper($1, *args) : super
      end

      def url_helper(name)
        case name
        when /base/ then Travian.config.server
        when /resources/ then base_url + "/dorf1.php"
        end
      end

      module_function

      def base_url
        Travian.config.server
      end
    end
  end
end
