# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'aptible/rails/version'

Gem::Specification.new do |spec|
  spec.name          = 'aptible-rails'
  spec.version       = Aptible::Rails::VERSION
  spec.authors       = ['Frank Macreery']
  spec.email         = ['frank@macreery.com']
  spec.description   = %q(Rails helpers for Aptible service applications)
  spec.summary       = %q(Rails helpers for Aptible service applications)
  spec.homepage      = 'https://github.com/aptible/aptible-rails'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'gem_config'
  spec.add_dependency 'aptible-auth'
  spec.add_dependency 'aptible-api'
  spec.add_dependency 'fridge'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'aptible-tasks'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.0'
end
