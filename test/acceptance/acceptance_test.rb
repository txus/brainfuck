require 'test_helper'

class BrainfuckAcceptanceTest < MiniTest::Unit::TestCase

  def test_without_loops_nor_user_input
    $stdout.expects(:print).times(2)
    assert_evaluates [2,1], "++++>++++---.<--."
  end

  def test_with_user_input
    stack = Brainfuck::Stack.new
    Brainfuck::Interpreter.stubs(:stack).returns stack
    stack.expects(:get_character).returns 97

    assert_evaluates [101], ",++++"
  end

  def test_with_loops
    assert_evaluates [1], "++++[-]+-+"
  end

  def test_transfers_from_one_cell_to_another
    assert_evaluates [0, 10], "++++++++++      [>+<-]"
  end

  def test_transfers_from_one_cell_to_the_third
    assert_evaluates [0, 0, 10], "++++++++++      [>+<-]>[>+<-]"
  end

  def test_transfers_from_one_cell_to_the_third_and_back_to_the_second
    assert_evaluates [0, 10, 0], "++++++++++      [>+<-]>[>+<-]>[<+>-]"
  end

  def test_nested_loop_examples
    assert_evaluates [0], "[++++++++++[-]+-+-]"
  end

  def test_hello_world
    assert_evaluates [0, 87, 100, 33, 10], <<-EOS
      +++++ +++++            
      [                      
          > +++++ ++         
          > +++++ +++++      
          > +++              
          > +                
          <<<< -              
      ]                   
      > ++ .                  
      > + .                   
      +++++ ++ .              
      .                       
      +++ .                   
      > ++ .                  
      << +++++ +++++ +++++ .  
      > .                     
      +++ .                   
      ----- - .               
      ----- --- .             
      > + .                   
      > .                     
  EOS
  end

  private

  def assert_evaluates(expected, code)
    assert_equal expected, Brainfuck.run(code)
  end
end
