require 'mechanize'
require 'travian/configurable'
require 'travian/api'
require 'travian/base_building'

module Travian

  class InvalidConfigurationError < StandardError ; end

  class Client
    include Configurable
    include API

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
      :profile    => '/spieler.php',
    }

    attr_reader :start_village

    def initialize(options)
      @agent = Mechanize.new
      Travian::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end
      raise InvalidConfigurationError, "Invalid user or password" unless configured? and login
      @start_village = @agent.current_page.search('ul#villageListLinks a.active').first.text
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

    def reset_village
      get(:resources, :village => village(@start_village))
      @start_village
    end

    def url_for(page, object=nil, params={})
      url = LINK_TO[page]
      url += "?newdid=#{object.id}" if object
      if params.size > 0
        url += "&" if object
        url += "?" unless object
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
