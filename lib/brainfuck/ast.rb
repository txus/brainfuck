module Brainfuck
  module AST
    class FwdNode < Struct.new(:stack)
      def eval; stack.fwd ; end
      def bytecode(g)
        g.push_literal 1
        g.push 1
        g.meta_send_op_plus(0)
        puts g.state.scope.methods.sort
        g.set_literal g.state.scope.new_literal(:pointer).reference.slot
        g.pop
      end
    end
    class BwdNode < Struct.new(:stack)
      def eval; stack.bwd ; end
      def bytecode(g)
        g.push 1
      end
    end

    class IncNode < Struct.new(:stack)
      def eval; stack.inc ; end
      def bytecode(g)
        g.push 1
      end
    end
    class DecNode < Struct.new(:stack)
      def eval; stack.dec ; end
      def bytecode(g)
        g.push 1
      end
    end
    class PutsNode < Struct.new(:stack)
      def eval; stack.puts ; end
      def bytecode(g)
        g.push 1
      end
    end
    class GetsNode < Struct.new(:stack)
      def eval; stack.gets ; end
      def bytecode(g)
        g.push 1
      end
    end
    class IterationNode < Struct.new(:stack, :exp)
      def eval
        until stack.current == 0
          exp.each do |node|
            node.eval
          end
        end
      end
    end
    class Script < Struct.new(:exp)

      def bytecode(g)
        g.push 0
        g.make_array 1
        g.set_literal g.state.scope.new_literal(:heap).reference.slot
        g.pop

        g.push 0
        g.set_literal g.state.scope.new_literal(:pointer).reference.slot
        g.pop

        exp.each do |e|
          e.bytecode(g)
        end
      end
    end
  end
end
