require "travian/version"
require "travian/configuration"
require "travian/village"
require "travian/attack"
require "travian/travian"

Travian.configure do |cfg|
  cfg.server = 'tx3.travian.com.br'
  cfg.user = 'jasoares'
  cfg.password = 'frohike'
end

Travian.login
