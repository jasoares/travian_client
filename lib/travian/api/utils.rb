module Travian
  module API
    module Utils

      def object_from_page(klass, request_method, path, params={})
        page = send(request_method.to_sym, path, params)
        klass.new(page)
      end

    end
  end
end
