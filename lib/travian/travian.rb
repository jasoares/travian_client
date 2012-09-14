require 'mechanize'

module Travian

  class InvalidConfigurationError < ArgumentError ; end

  @@config = Configuration.new
  @@agent = Mechanize.new

  class << self

    def configure
      yield @@config
      return @@config
    end

    def config
      @@config
    end

    def login
      login_form = @@agent.get("http://#{@@config.server}/").form
      username_field = login_form.fields.find {|f| f.name = "name" }
      username_field.value = @@config.user
      login_form.password = @@config.password
      page = @@agent.submit(login_form)
      return page if page.search('.error.LTR').empty?
      raise InvalidConfigurationError
    end

    def bot
      @@agent
    end
  end
end
