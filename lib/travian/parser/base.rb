require 'travian/parser'
require 'travian/parser/common'

module Travian
  module Parser
    class Base
      include Travian::Parser
      include Travian::Parser::Common

      attr_reader :page

      def initialize(page)
        @page = page
      end

    end
  end
end
