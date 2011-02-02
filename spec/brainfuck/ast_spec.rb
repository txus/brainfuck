require 'spec_helper'

module Brainfuck
  describe AST do
    let(:stack) { double('stack') }

    %w{fwd bwd inc dec puts gets}.each do |node|
      describe "AST::#{node.capitalize}Node" do
        subject { eval("AST::#{node.capitalize}Node").new stack }
        describe "#eval" do
          it "calls stack##{node}" do
            subject.stack.should_receive(node)
            subject.eval
          end
        end
      end
    end

    describe AST::IterationNode do
      let(:nodes) do
        [ double('node'), double('node2') ]
      end
      subject { AST::IterationNode.new stack, nodes }
      describe "#eval" do
        it 'evaluates the expression until the stack cell is 0' do
          subject.stack.stub(:current).and_return 3, 2, 1, 0
          nodes.each do |node|
            node.should_receive(:eval).exactly(3).times
          end
          subject.eval
        end
      end
    end

  end
end
