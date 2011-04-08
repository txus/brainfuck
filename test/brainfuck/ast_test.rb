require 'test_helper'

module Brainfuck
  class ASTTest < MiniTest::Unit::TestCase

    %w{fwd bwd inc dec puts gets}.each do |node|
      define_method("test_ast_#{node}_node_eval_delegates_to_the_stack") do
        subject = eval("AST::#{node.capitalize}Node").new stub(:stack)
        subject.stack.expects(node)
        subject.eval
      end
    end

    def test_iteration_node_evaluates_until_cell_is_zero
      nodes = [stub(:node), stub(:node)]
      subject = AST::IterationNode.new stub(:stack), nodes
      subject.stack.stubs(:current).returns 3, 2, 1, 0

      nodes.each do |node|
        node.expects(:eval).times(3)
      end
      subject.eval
    end

  end
end
