module Brainfuck
  class Compiler < Rubinius::Compiler

    def self.compiled_filename(filename)
      if filename =~ /.bf$/
        filename + "c"
      else
        filename + ".compiled.bfc"
      end
    end

    def self.always_recompile=(flag)
      @always_recompile = flag
    end

    def self.compile_if_needed(file, output = nil, print = Print.new)
      compiled = output || compiled_filename(file)
      needed = @always_recompile || !File.exists?(compiled) ||
        File.stat(compiled).mtime < File.stat(file).mtime
      if needed
        compile_file(file, compiled, print)
      else
        Brainfuck::CodeLoader.new(compiled).load_compiled_file(compiled, 0)
      end
    end


    def self.compile_file(file, output = nil, print = Print.new)
      compiler = new :brainfuck_file, :compiled_file
      parser = compiler.parser

      parser.input file

      compiler.generator = Rubinius::Generator.new
      compiler.writer.name = output || compiled_filename(file)

      parser.print = print
      compiler.packager.print.bytecode = true if print.asm?

      begin
        compiler.run

      rescue Exception => e
        compiler_error "Error trying to compile brainfuck: #{file}", e
      end
    end

    def self.compile_for_eval(code, variable_scope, file = "(eval)", line = 0, print = Print.new)
      compiler = new :brainfuck_code, :compiled_method
      parser = compiler.parser

      parser.input code, file, line
      compiler.generator.root = Rubinius::AST::EvalExpression
      compiler.generator.variable_scope = variable_scope

      parser.print = print
      compiler.packager.print.bytecode = true if print.asm?

      begin
        compiler.run
      rescue Exception => e
        compiler_error "Error trying to compile brainfuck: #{file}", e
      end
    end

    class Print < Struct.new(:sexp, :ast, :heap, :asm)
      def sexp?
        @sexp
      end

      def ast?
        @ast
      end

      def heap?
        @heap
      end

      def asm?
        @asm
      end
    end

  end
end
