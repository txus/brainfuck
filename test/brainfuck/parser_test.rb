require 'test_helper'

module Brainfuck
  class ParserTest < MiniTest::Unit::TestCase

    %w{fwd bwd inc dec puts gets iteration exp}.each do |rule|
      define_method "test_implements_a_#{rule}_rule" do
        rules = Parser.rules.map(&:first).map do |pattern|
          pattern.instance_variable_get(:@pattern)
        end.map(&:keys).flatten
        assert_includes rules, rule.to_sym
      end
    end

  end
end
