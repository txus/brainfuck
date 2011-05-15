require 'test_helper'

module Brainfuck
  class LexerTest < MiniTest::Unit::TestCase

    def test_INSTRUCTIONS_returns_valid_symbols
      assert_equal %w{> < + - [ ] . ,}, Lexer::INSTRUCTIONS
    end

    def test_clean_cleans_all_invalid_symbols
      assert_equal '><+-[-].,', Lexer.clean(">3< 223+fn - ()()[r23-] .bdn*& ,")
    end

    %w{lparen rparen space space? fwd bwd inc dec puts gets iteration expression}.each do |rule|
      define_method("test_implements_a_#{rule}_rule") do
        assert Lexer.new.respond_to?(rule), "Parser should implement a #{rule} rule"
      end
    end

  end
end
