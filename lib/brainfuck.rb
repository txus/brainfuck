require 'parslet'
require 'highline/system_extensions'

require 'brainfuck/stack'
require 'brainfuck/ast'

require 'brainfuck/parser'
require 'brainfuck/interpreter'
require 'brainfuck/stages'
require 'brainfuck/compiler'
require 'brainfuck/main'
require 'brainfuck/code_loader'

module Brainfuck
  class << self
    def run code
      Interpreter.stack.clear

      code = Parser.clean code
      parsed = Parser.new.parse code
      ast = Interpreter.new.apply parsed
      Compiler.compile_ast ast, 'file', Compiler::Print.new(true, true, true)
      ast.each(&:eval)
      Interpreter.stack.to_a
    end
  end
end
