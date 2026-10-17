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
  # Last releases whose own gemspecs still allow Ruby 2.0.
  # Later rake needs 2.2, later minitest needs 2.3, and benchmark-ips
  # does not declare a Ruby requirement so a newer release would be
  # installed on Ruby 2.0 and then fail.
  s.add_development_dependency 'benchmark-ips', '~> 2.7.2'
  s.add_development_dependency 'minitest', '~> 5.11.3'
  s.add_development_dependency 'rake', '~> 12.3.3'
end
