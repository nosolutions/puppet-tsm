source ENV['GEM_SOURCE'] || "https://rubygems.org"

group :development, :unit_test do
  gem 'rake',                     :require => false
  gem 'metadata-json-lint',       :require => false
  gem 'puppetlabs_spec_helper',   :require => false
  gem 'rspec-puppet', '>= 2.3.2', :require => false
  gem 'rspec-puppet-facts',       :require => false
  gem 'puppet-lint',              :require => false
  gem 'coveralls',                :require => false
  gem 'simplecov',                :require => false
  gem 'simplecov-console',        :require => false
end

if puppetversion = ENV['PUPPET_GEM_VERSION']
  gem 'puppet', puppetversion, :require => false
else
  gem 'puppet', :require => false
end
