# -*- encoding: utf-8 -*-
require File.expand_path('../lib/travian/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["João Soares"]
  gem.email         = ["jsoaresgeral@gmail.com"]
  gem.description   = %q{Access Travian account status and interact with the game through mechanize}
  gem.summary       = %q{Travian mechanized access library}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "travian"
  gem.require_paths = ["lib"]
  gem.version       = Travian::VERSION

  # Dependencies
  
  # runtime
  gem.add_runtime_dependency 'mechanize'

  # development
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'cucumber'
  gem.add_development_dependency 'fakeweb'
end
