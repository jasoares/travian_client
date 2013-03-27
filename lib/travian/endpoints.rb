module Travian
  module Endpoints

    def resources(id=nil, options={})
      send(Travian::Parser::ResourceFields, :get, "/dorf1.php#{id}", options)
    end

    def buildings(id=nil, options={})
      send(Travian::Parser::Buildings, :get, "/dorf2.php", options)
    end

  end
end
