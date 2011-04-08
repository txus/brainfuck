require 'simplecov'
SimpleCov.start do
  add_group "Lib", "lib"
end

gem 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'mocha'

require 'brainfuck'
