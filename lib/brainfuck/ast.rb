module Brainfuck
  module AST
    class FwdNode
      def bytecode(g)
        g.push_local 1
        g.meta_push_1
        g.meta_send_op_plus 0
        g.set_local 1

        # Check the contents of the new cell
        g.push_local 0   
        g.swap_stack
        g.send :[], 1, false

        fin = g.new_label
        g.git fin
        g.pop

        # If the cell is nil set it to 0
        g.push_local 0
        g.push_local 1
        g.meta_push_0
        g.send :[]=, 2, false

        # Otherwise, do nothing
        fin.set!
      end
    end
    class BwdNode
      def bytecode(g)
        g.push_local 1
        g.meta_push_1
        g.meta_send_op_minus 0
        g.set_local 1

        # Check the contents of the new cell
        g.push_local 0   
        g.swap_stack
        g.send :[], 1, false

        fin = g.new_label
        g.git fin
        g.pop

        # If the cell is nil set it to 0
        g.push_local 0
        g.push_local 1
        g.meta_push_0
        g.send :[]=, 2, false

        # Otherwise, do nothing
        fin.set!
      end
    end

    class IncNode
      def bytecode(g)
        g.push_local 0
        g.push_local 1

        g.dup_many(2)
        g.send :[], 1, false
        g.meta_push_1
        g.meta_send_op_plus 0

        g.send :[]=, 2, false
        g.pop
      end
    end
    class DecNode
      def bytecode(g)
        g.push_local 0
        g.push_local 1

        g.dup_many(2)
        g.send :[], 1, false
        g.meta_push_1
        g.meta_send_op_minus 0

        g.send :[]=, 2, false
        g.pop
      end
    end
    class PutsNode
      def bytecode(g)
        g.push_local 0
        g.push_local 1
        g.send :[], 1, false
        g.send :chr, 0, true
        g.send :puts, 1, true
      end
    end
    class GetsNode
      def bytecode(g)
        g.push :self
        g.push_literal "stty raw -echo"
        g.send :system, 1, true
        g.pop

        g.push_local 0
        g.push_local 1

        g.push_const :STDIN
        g.send :getc, 0, false

        g.send :[]=, 2, false

        g.push :self
        g.push_literal "stty -raw echo"
        g.send :system, 1, true
        g.pop
      end
    end
    class IterationNode < Struct.new(:exp)
      def bytecode(g)
        repeat = g.new_label
        repeat.set!

        exp.bytecode(g)

        g.push_local 0
        g.push_local 1
        g.send :[], 1, true
        g.meta_push_0
        g.meta_send_op_equal 0

        g.gif repeat
      end
    end
    class Script < Struct.new(:exp)
      def bytecode(g)
        exp.each do |e|
          e.bytecode(g)
        end
      end
    end
  end
end
