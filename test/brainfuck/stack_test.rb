require 'test_helper'

module Brainfuck
  class StackTest < MiniTest::Unit::TestCase
    def setup
      @stack = Stack.new
    end

    def test_current_returns_the_current_value_of_the_stack
      assert_equal 0, @stack.current
    end

    def test_fwd_advances_the_pointer
      @stack.fwd
      assert_equal 1, @stack.instance_variable_get(:@pointer)
    end

    def test_bwd_decreases_the_pointer
      @stack.instance_variable_set(:@pointer, 4)
      @stack.bwd
      assert_equal 3, @stack.instance_variable_get(:@pointer)
    end

    def test_raises_if_the_pointer_tries_to_go_below_zero
      @stack.instance_variable_set(:@pointer, 0)
      assert_raises RuntimeError, "Tried to access cell -1" do
        @stack.bwd
      end
    end

    def test_inc_increases_the_current_cell
      @stack.instance_variable_set(:@stack, [4])
      @stack.inc
      assert_equal 5, @stack.current
    end

    def test_dec_decreases_the_current_cell
      @stack.instance_variable_set(:@stack, [4])
      @stack.dec
      assert_equal 3, @stack.current
    end

    def test_puts_prints_the_current_character
      $stdout.expects(:print).with 'A'

      @stack.stubs(:current).returns 65
      @stack.puts
    end

    def test_gets_fetches_from_stdin
      @stack.expects(:get_character).returns 97
      @stack.gets
      assert_equal 97, @stack.current
    end

    def test_to_a_returns_the_stack_array
      assert_equal [0], @stack.to_a
    end

    def test_clear_clears_the_stack
      @stack.expects(:initialize)
      @stack.clear
    end
  end
end
