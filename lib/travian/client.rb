require 'mechanize'
require 'uri'
require 'travian/configurable'
require 'travian/parser/view'
require 'travian/api'
require 'travian/api/villages'
require 'travian/api/users'
require 'travian/api/attacks'
require 'travian/api/resources'
require 'travian/base_building'

module Travian

  class InvalidConfigurationError < StandardError ; end

  class Client
    include Configurable
    include API
    include API::Villages
    include API::Users
    include API::Attacks
    include API::Resources

    ANSWERS = URI.parse('http://t4.answers.travian.org/index.php')

    LINK_TO = {
      :root       => '/',
      :resources  => '/dorf1.php',
      :center     => '/dorf2.php',
      :statistics => '/statistiken.php',
      :reports    => '/berichte.php',
      :messages   => '/nachrichten.php',
      :map        => '/karte.php',
      :villages   => '/dorf3.php',
      :building   => '/build.php',
      :user       => '/spieler.php',
      :alliance   => '/allianz.php',
    }

    attr_reader :agent, :start_village

    def initialize(options)
      @agent = Mechanize.new
      Travian::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end
      raise InvalidConfigurationError, "Invalid user or password" unless configured? and login
      @start_village = current_village
    end

    def answers(object, opts={})
      options = { view: 'toolkit' }
      case object
      when BaseBuilding
        options[:action] = 'building'
        options[:gid] = object.gid
      when Unit
        options[:action] = 'troopsoverview'
      end
      options[:speed] = 3
      options[:unwrapped] = ''
      uri = ANSWERS.clone
      uri.query = URI.encode_www_form(options)
      get(uri.to_s)
    end

    def get(page, village=nil, params={})
      unless page.is_a? String
        page = "http://#{options[:server]}" + url_for(page, village, params)
      end
      @agent.get(page)
    end

    def fetch(url={})
      agent.get url.is_a?(String) ? url : answers(url)
    end

    def url_for(page, object=nil, params={})
      url = LINK_TO[page]
      url += "?newdid=#{object.id}" if object
      if params.size > 0
        object ? url += "&" : url += "?"
      end
      url += params.each_pair.map do |k,v|
        k == :gid ? "#{k}=#{BaseBuilding.gid_for(v)}" : "#{k}=#{v}"
      end.join("&")
    end

    private

    def login
      login_form = get("http://#{credentials[:server]}").form
      username_field = login_form.fields.find {|f| f.name = "name" }
      username_field.value = credentials[:user]
      login_form.password = credentials[:password]
      login_form.checkbox_with(:name => 'lowRes').check
      @agent.submit(login_form).search('.error.LTR').empty?
    rescue
      raise InvalidConfigurationError,
        'Invalid server address, do not include "http://"'
    end
  end
end
