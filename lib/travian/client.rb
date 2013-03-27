require 'mechanize'
require 'uri'
require 'travian/configurable'
require 'travian/endpoints/account'
require 'travian/base_building'

module Travian

  class InvalidConfigurationError < StandardError ; end

  class Client
    include Configurable
    include Travian::Endpoints::Account

    # ANSWERS = URI.parse('http://t4.answers.travian.org/index.php')

    # LINK_TO = {
    #   :root       => '/',
    #   :resources  => '/dorf1.php',
    #   :center     => '/dorf2.php',
    #   :statistics => '/statistiken.php',
    #   :reports    => '/berichte.php',
    #   :messages   => '/nachrichten.php',
    #   :map        => '/karte.php',
    #   :villages   => '/dorf3.php',
    #   :building   => '/build.php',
    #   :user       => '/spieler.php',
    #   :alliance   => '/allianz.php',
    # }

    attr_reader :agent, :start_village

    def initialize(options)
      @agent = Mechanize.new
      Travian::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end
      raise InvalidConfigurationError, "Invalid user or password" unless configured? and login
      @start_village = current_village
    end

    # def answers(object, opts={})
    #   options = { view: 'toolkit' }
    #   case object
    #   when BaseBuilding
    #     options[:action] = 'building'
    #     options[:gid] = object.gid
    #   when Unit
    #     options[:action] = 'troopsoverview'
    #   end
    #   options[:speed] = 3
    #   options[:unwrapped] = ''
    #   uri = ANSWERS.clone
    #   uri.query = URI.encode_www_form(options)
    #   get(uri.to_s)
    # end

    # def get(page, village=nil, params={})
    #   unless page.is_a? String
    #     page = "http://#{options[:server]}" + url_for(page, village, params)
    #   end
    #   @agent.get(page)
    # end

    def fetch(url)
      connection.get url
    end

    # def url_for(page, object=nil, params={})
    #   url = LINK_TO[page]
    #   url += "?newdid=#{object.id}" if object
    #   if params.size > 0
    #     object ? url += "&" : url += "?"
    #   end
    #   url += params.each_pair.map do |k,v|
    #     k == :gid ? "#{k}=#{BaseBuilding.gid_for(v)}" : "#{k}=#{v}"
    #   end.join("&")
    # end

    def get(path, params={})
      request(:get, path, params)
    end

    def post(path, params={})
      request(:post, path, params)
    end

    def put(path, params={})
      request(:put, path, params)
    end

    def delete(path, params={})
      request(:delete, path, params)
    end

    def request(request_method, path, params)
      connection.send(request_method.to_sym, path, params)
    end

    def connection
      @agent
    end
  end
end
