# -*- encoding: utf-8 -*-
require File.expand_path('../lib/travian/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["João Soares"]
  gem.email         = ["jsoaresgeral@gmail.com"]
  gem.description   = %q{Access Travian account status and interact with the game through mechanize}
  gem.summary       = %q{Travian mechanized access library}
  gem.homepage      = "http://github.com/jasoares/travian_client"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(spec)/})
  gem.name          = "travian"
  gem.require_paths = ["lib"]
  gem.version       = Travian::VERSION

  # Dependencies
  
  # runtime
  gem.add_runtime_dependency 'mechanize'
  gem.add_runtime_dependency 'active_support'

  # development
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'fakeweb'
  gem.add_development_dependency 'timecop'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-inotify'
end
