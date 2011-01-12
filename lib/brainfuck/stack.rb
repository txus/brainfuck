module Brainfuck
  class Stack
    include HighLine::SystemExtensions

    attr_reader :current
    def initialize
      @pointer = 0
      @stack = [0]
    end
    def current
      @stack[@pointer]
    end
    def fwd
      @pointer += 1
      initialize_cell_if_nil
    end
    def bwd
      @pointer -= 1
      ensure_pointer_is_above_zero
      initialize_cell_if_nil
    end
    def inc
      @stack[@pointer] = (current + 1) % 255
    end
    def dec
      @stack[@pointer] = (current - 1) % 255
    end
    def puts
      $stdout.print current.chr
    end
    def gets
      @stack[@pointer] = (get_character % 255) rescue 0
    end

    def to_a
      @stack
    end

    def clear
      initialize
    end

    private
    def initialize_cell_if_nil
      @stack[@pointer] ||= 0
    end
    def ensure_pointer_is_above_zero
      raise "Tried to access cell #{@pointer}." if @pointer < 0
    end
  end
end
