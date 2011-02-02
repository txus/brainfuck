require 'spec_helper'

module Brainfuck
  describe Parser do

    describe "INSTRUCTIONS constant" do
      it 'returns valid symbols' do
        Parser::INSTRUCTIONS.should == %w{> < + - [ ] . ,}
      end
    end

    describe ".clean" do
      it 'cleans all non-valid symbols from a string' do
        Parser.clean(">3< 223+fn - ()()[r23-] .bdn*& ,").should == '><+-[-].,'
      end
    end

    describe "rules" do
      %w{lparen rparen space space? fwd bwd inc dec puts gets iteration expression}.each do |rule|
        it "implements a rule for :#{rule} node" do
          subject.should respond_to(:"#{rule}")
        end
      end
    end
    
  end
end
