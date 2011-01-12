require 'spec_helper'

describe Brainfuck do

  describe ".run" do
    it 'runs the code and returns the stack' do
      code = double('code') 
      parsed = double('parsed')
      ast = [double('node'), double('node')]

      Brainfuck::Interpreter.stack.should_receive(:clear)

      Brainfuck::Parser.should_receive(:clean).with("code").and_return(code)
      Brainfuck::Parser.stub_chain('new.parse').with(code).and_return parsed
      Brainfuck::Interpreter.stub_chain('new.apply').with(parsed).and_return ast
      
      ast.each { |n| n.should_receive(:eval) }

      subject.run("code").should === Brainfuck::Interpreter.stack.to_a
    end
  end   

end
