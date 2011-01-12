module Brainfuck
  module AST
    class FwdNode < Struct.new(:stack)
      def eval; stack.fwd ; end
    end
    class BwdNode < Struct.new(:stack)
      def eval; stack.bwd ; end
    end

    class IncNode < Struct.new(:stack)
      def eval; stack.inc ; end
    end
    class DecNode < Struct.new(:stack)
      def eval; stack.dec ; end
    end
    class PutsNode < Struct.new(:stack)
      def eval; stack.puts ; end
    end
    class GetsNode < Struct.new(:stack)
      def eval; stack.gets ; end
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
  end
end
