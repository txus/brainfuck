require 'highline/system_extensions'

module Brainfuck
  class Interpreter
    include HighLine::SystemExtensions

    INSTRUCTIONS = %w{> < + - [ ] . ,}

    attr_accessor :cells
    attr_reader :pointer
    attr_reader :code

    def initialize
      @cells = [0]
      @pointer = 0
      @code = nil
    end

    def current
      @cells[pointer] ||= 0
    end
    def current=(value)
      @cells[pointer] = (value % 255) rescue 0
    end

    def forward
      @pointer += 1
      initialize_cell_if_nil
    end
    def backward
      @pointer -= 1
      ensure_pointer_is_above_zero
      initialize_cell_if_nil
    end
    def increase
      @cells[pointer] = (@cells[pointer] + 1) % 255
    end
    def decrease
      @cells[pointer] = (@cells[pointer] - 1) % 255
    end

    def compile(code)
      @code = clean(code)
      run
    end

    def run(from = nil, to = nil)
      index = 0
      context = 0

      c = code.dup

      if from && to
        context = from 
        c = c.slice(from...to)
      end

      c.each_char do |char|
        index += 1
        case char
          when '>'
            forward 
          when '<'
            backward 
          when '+'
            increase
          when '-'
            decrease
          when '.'
            stdout.print current.chr
          when ','
            self.current = get_character
          when '['
            @start = index
          when ']'
            @end = index unless @end && @start < @end
            run(@start, @end) unless current == 0
            @start = context || nil
        end
      end
    end

    private

    def clean(code)
      code.chars.select {|c| INSTRUCTIONS.include? c }.join
    end

    def stdout
      $stdout
    end

    def initialize_cell_if_nil
      @cells[pointer] ||= 0
    end

    def ensure_pointer_is_above_zero
      raise "Tried to access cell #{@pointer}." if @pointer < 0
    end

  end
end
