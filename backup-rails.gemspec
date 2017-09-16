# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'backup-rails/version'

Gem::Specification.new do |gem|
  gem.name          = "backup-rails"
  gem.version       = Backup::Rails::VERSION
  gem.authors       = ["Oleg Bavaev"]
  gem.email         = ["jesoba7@gmail.com"]
  gem.description   = %q{Backup rails project with backup & whenever gems}
  gem.summary       = %q{Backup rails project}
  gem.homepage      = "https://github.com/jesson/backup-rails"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'backup', '= 3.4.0'
  gem.add_runtime_dependency 'whenever'
  gem.add_runtime_dependency 'dotenv-rails'
  gem.add_runtime_dependency 'fog', '~> 1.9'
  gem.add_runtime_dependency 'net-ssh', '>= 2.3.0', '<= 2.5.2'
  gem.add_runtime_dependency 'excon', '~> 0.17'
  gem.add_runtime_dependency 'mail', '~> 2.5'
end

