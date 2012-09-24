require 'mechanize'
require 'travian/configurable'
require 'travian/helpers/url_helper'
require 'travian/api'

module Travian

  class InvalidConfigurationError < StandardError ; end

  class Client
    include Configurable
    include Helpers::UrlHelper
    include API

    attr_reader :start_village

    def initialize(options)
      @agent = Mechanize.new
      Travian::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", options[key])
      end
      raise InvalidConfigurationError unless configured? && login
    end

    def get(page, village=nil, params={})
      unless page.is_a? String
        page = "http://#{options[:server]}" + url_for(page, village, params)
      end
      @agent.get(page)
    end

    def reset_village
      get(:resources, :village => village(@start_village))
      @start_village
    end

    private

    def login
      login_form = get("http://#{credentials[:server]}").form
      username_field = login_form.fields.find {|f| f.name = "name" }
      username_field.value = credentials[:user]
      login_form.password = credentials[:password]
      login_form.checkbox_with(:name => 'lowRes').check
      @agent.submit(login_form).search('.error.LTR').empty?
      @start_village = @agent.current_page.search('ul#villageListLinks a.active').first.text
    end
  end
end
