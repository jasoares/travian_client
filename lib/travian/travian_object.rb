module Travian
  class TravianObject
    class << self
      include Helpers::UrlHelper
      include Helpers::BuildingHelper
    end
  end
end