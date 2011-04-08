require 'test_helper'

class BrainfuckTest < MiniTest::Unit::TestCase

  def test_run
    code, parsed = stub(:code), stub(:parsed)
    ast = [stub(:node), stub(:node)]

    Brainfuck::Parser.expects(:clean).with("code").returns code
    Brainfuck::Parser.any_instance.stubs(:parse).with(code).returns parsed
    Brainfuck::Interpreter.any_instance.stubs(:apply).with(parsed).returns ast

    ast.each { |node| node.expects(:eval) }

    assert_equal Brainfuck::Interpreter.stack.to_a, Brainfuck.run("code")
  end

end
