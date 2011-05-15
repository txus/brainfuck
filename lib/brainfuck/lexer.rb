module Brainfuck
  class Lexer < Parslet::Parser
    INSTRUCTIONS = %w{> < + - [ ] . ,}

    alias_method :tokenize, :parse
    class << self
      def clean code
        code.chars.select {|c| INSTRUCTIONS.include? c }.join
      end
    end

    rule(:lparen)     { str('[') >> space? }
    rule(:rparen)     { str(']') >> space? }

    rule(:space)      { match('\s').repeat(1) }
    rule(:space?)     { space.maybe }

    rule(:fwd)        { str('>') >> space? }
    rule(:bwd)        { str('<') >> space? }

    rule(:inc)        { str('+') >> space? }
    rule(:dec)        { str('-') >> space? }

    rule(:puts)       { str('.') >> space? }
    rule(:gets)       { str(',') >> space? }

    rule(:iteration)  { lparen >> expression >> rparen }

    rule(:expression) { (iteration.as(:iteration) | fwd.as(:fwd) | bwd.as(:bwd) | inc.as(:inc) | dec.as(:dec) | puts.as(:puts) | gets.as(:gets)).repeat.as(:exp) }
    root :expression
  end
end
