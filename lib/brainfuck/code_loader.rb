module Brainfuck
  class CodeLoader < Rubinius::CodeLoader

    def self.execute_code(code, binding, from_module, print = Compiler::Print.new)
      cm = Compiler.compile_for_eval(code, binding.variables,
                                     "(eval)", 1, print)
      cm.scope = binding.static_scope.dup
      cm.name = :__eval__

      script = Rubinius::CompiledMethod::Script.new(cm, "(eval)", true)
      script.eval_binding = binding
      script.eval_source = code

      cm.scope.script = script

      be = Rubinius::BlockEnvironment.new
      be.under_context(binding.variables, cm)
      be.from_eval!
      be.call
    end

    # Takes a .bf file name, compiles it if needed and executes it.
    def self.execute_file(name, compile_to = nil, print = Compiler::Print.new)
      cm = Compiler.compile_if_needed(name, compile_to, print)
      ss = ::Rubinius::StaticScope.new Object
      code = Object.new
      ::Rubinius.attach_method(:__run__, cm, ss, code)
      code.__run__
    end
  end
end
