require 'spec_helper'

module Brainfuck
  describe Interpreter do

    describe ".stack" do
      it 'returns a new or cached Stack' do
        stack = Interpreter.stack
        stack.should be_kind_of(Stack)
        Interpreter.stack.should === stack
      end
    end

    describe "rules" do
      %w{fwd bwd inc dec puts gets iteration exp}.each do |rule|
        it "implements a rule for :#{rule} node" do
          subject.rules.map(&:first).map do |pattern|
            pattern.instance_variable_get(:@pattern)
          end.map(&:keys).flatten.should include(:"#{rule}")
        end
      end
    end
    
  end
end
