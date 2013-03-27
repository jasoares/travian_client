module Travian
  module Endpoints
    module Utils

      def object_from_response(klass, endpoint, request_method, path, options={})
        response = send(endpoint.to_sym, request_method, path, idize_options(options))
        klass.from_response(response)
      end

      def object_from_responses(klass, *responses)
        klass.from_responses(*responses)
      end

      def objects_from_array(klass, array)
        array.map do |element|
          klass.from_response(element)
        end
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
