require 'puppetlabs_spec_helper/module_spec_helper'
require 'rspec-puppet-facts'

require 'simplecov'
require 'simplecov-console'

include RspecPuppetFacts

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
  formatter SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::Console
  ])
end

begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
end
