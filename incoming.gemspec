# -*- encoding: utf-8 -*-
require File.expand_path('../lib/incoming/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Tim Cooper"]
  gem.email         = ["coop@latrobest.com"]
  gem.description   = "Parse incoming payloads"
  gem.summary       = "Parse incoming payloads"
  gem.homepage      = "http://github.com/everydayhero/incoming"

  gem.files         = `git ls-files`.split($\)
  gem.test_files    = gem.files.grep(%r{^(test)/})
  gem.name          = "incoming"
  gem.require_paths = ["lib"]
  gem.version       = Incoming::VERSION
end
