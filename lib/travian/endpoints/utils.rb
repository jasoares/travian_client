module Travian
  module Endpoints
    module Utils

      def parse_response(klass, endpoint, request_method, path, options={})
        response = send(endpoint.to_sym, request_method, path, idize_options(options))
        klass.new(response).attrs
      end

    private

      def idize_options(options)
        options.each_pair do |key, value|
          options[key] = value.respond_to?(:id) ? value.id : value
        end
      end

    end
  end
end
