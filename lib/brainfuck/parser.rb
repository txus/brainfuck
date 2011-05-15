module Brainfuck
  class Parser < Parslet::Transform
    rule(:fwd => simple(:fwd))            { AST::FwdNode.new }
    rule(:bwd => simple(:bwd))            { AST::BwdNode.new }

    rule(:inc => simple(:inc))            { AST::IncNode.new }
    rule(:dec => simple(:dec))            { AST::DecNode.new }

    rule(:puts => simple(:puts))          { AST::PutsNode.new }
    rule(:gets => simple(:gets))          { AST::GetsNode.new }

    rule(:iteration => subtree(:iteration)) { AST::IterationNode.new(iteration) }

    rule(:exp => subtree(:exp)) { AST::Script.new(exp) }
  end
end
