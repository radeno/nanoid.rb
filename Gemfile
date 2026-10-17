source 'https://rubygems.org'
ruby '>= 2.0'

gemspec

# These left the default gems in Ruby 3.4/4.0. Rake 12 and Minitest 5.11
# still require them, and neither gem installs on Ruby 2.0.
if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.4')
  gem 'mutex_m'
  gem 'ostruct'
end
