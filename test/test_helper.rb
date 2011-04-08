require 'rubygems' if RUBY_VERSION == '1.8.7'

require 'bundler/setup'

require 'simplecov'
SimpleCov.start do
  add_group "Lib", "lib"
end

gem 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'mocha'

require 'brainfuck'
