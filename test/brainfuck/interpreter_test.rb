require 'test_helper'

module Brainfuck
  class InterpreterTest < MiniTest::Unit::TestCase

    def test_stack_returns_a_new_or_cached_stack
      stack = Interpreter.stack
      assert_kind_of Stack, stack
      assert Interpreter.stack === stack
    end

    %w{fwd bwd inc dec puts gets iteration exp}.each do |rule|
      define_method "test_implements_a_#{rule}_rule" do
        rules = Interpreter.rules.map(&:first).map do |pattern|
          pattern.instance_variable_get(:@pattern)
        end.map(&:keys).flatten
        assert_includes rules, rule.to_sym
      end
    end

  end
end
