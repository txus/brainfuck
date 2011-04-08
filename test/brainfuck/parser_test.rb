require 'test_helper'

module Brainfuck
  class ParserTest < MiniTest::Unit::TestCase

    def test_INSTRUCTIONS_returns_valid_symbols
      assert_equal %w{> < + - [ ] . ,}, Parser::INSTRUCTIONS
    end

    def test_clean_cleans_all_invalid_symbols
      assert_equal '><+-[-].,', Parser.clean(">3< 223+fn - ()()[r23-] .bdn*& ,")
    end

    %w{lparen rparen space space? fwd bwd inc dec puts gets iteration expression}.each do |rule|
      define_method("test_implements_a_#{rule}_rule") do
        assert Parser.new.respond_to?(rule), "Parser should implement a #{rule} rule"
      end
    end

  end
end
