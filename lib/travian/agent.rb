require 'nokogiri'
require 'mechanize'
require 'net/http'

module Travian
  module Agent
    extend self

    ANSWERS_SERVER = 'http://t4.answers.travian.org/index.php?view=toolkit&action='

    def get(url={})
      agent.get url.is_a?(String) ? url : answers(url)
    end

    def agent
      @@agent ||= Mechanize.new
    end

    private

    def answers(hash={})
      return 'http://status.travian.com' if hash == :status
      url = ANSWERS_SERVER
      url += "building&gid=#{BaseBuilding.gid_for(hash[:building])}" if hash.key? :building
      url += "buildingconstructiontimes&gid=#{BaseBuilding.gid_for(hash[:const_times])}" if hash.key? :const_times
      url += "&speed=#{hash[:speed] || "1"}"
      url += "&unwrapped"
    end

    # Delegate to Mechanize
    # @return [Travian::Client]
    def method_missing(method_name, *args, &block)
      return super unless agent.respond_to? method_name
      agent.send(method_name, *args, &block)
    end
  end
end
