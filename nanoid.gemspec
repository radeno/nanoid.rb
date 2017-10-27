require File.expand_path('../lib/nanoid/version', __FILE__)

Gem::Specification.new do |s|
  s.name          = 'nanoid'
  s.version       = Gem::Version.new(NanoId::VERSION)
  s.authors       = ['Radovan Smitala']
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/radeno/nanoid.rb'
  s.summary       = 'Ruby implementation of Nanoid, secure URL-friendly unique ID generator'

  s.files         = Dir['lib/**/*.rb']
  s.platform      = Gem::Platform::RUBY
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 2.0'
  s.add_development_dependency 'bundler', '>= 1.15'
  s.add_development_dependency 'rake', '>= 12.0'
  s.add_development_dependency 'minitest', '>= 5.10'
  s.add_development_dependency 'reek', '>= 4.5'
  s.add_development_dependency 'rubocop', '>= 0.5'
end
