module Brainfuck
  class Interpreter < Parslet::Transform
    def self.stack
      @@stack ||= Stack.new
    end
    
    rule(:fwd => simple(:fwd))            { AST::FwdNode.new(Interpreter.stack) }
    rule(:bwd => simple(:bwd))            { AST::BwdNode.new(Interpreter.stack) }

    rule(:inc => simple(:inc))            { AST::IncNode.new(Interpreter.stack) }
    rule(:dec => simple(:dec))            { AST::DecNode.new(Interpreter.stack) }

    rule(:puts => simple(:puts))          { AST::PutsNode.new(Interpreter.stack) }
    rule(:gets => simple(:gets))          { AST::GetsNode.new(Interpreter.stack) }

    rule(:iteration => subtree(:iteration)) { AST::IterationNode.new(Interpreter.stack, iteration) }

    rule(:exp => subtree(:exp)) { exp }
  end
end
