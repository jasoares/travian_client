require 'travian/parser/base'

module Travian
  module Parser
    class Building < Travian::Parser::Base

      def attrs
        return nil unless exists?
        {
          id: nil
        }
      end

    private

      def exists?
        true
      end

    end
  end
end
