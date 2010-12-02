require 'spec_helper'

module Brainfuck
  describe Interpreter do
    subject { Interpreter.new }

    it "initializes with an array of cells with a single 0 element" do
      subject.cells.should == [0]
    end

    describe "#clean" do
      it "cleans the code from comments and whitespace" do
        subject.send(:clean, " < > h -  + ..,hb [lk]f").should == '<>-+..,[]'
      end
    end

    describe "#compile" do
      it "cleans the code first and runs it second" do
        code = double('code')
        subject.should_receive(:clean).once.with(code).ordered.and_return("")
        subject.should_receive(:run).once

        subject.compile(code)
      end
    end

    describe "#run" do
      it "converts > into forward" do
        subject.stub(:code).and_return ">"
        subject.should_receive(:forward).once
        subject.run
      end
      it "converts < into backward" do
        subject.stub(:code).and_return "<"
        subject.should_receive(:backward).once
        subject.run
      end
      it "converts + into increase" do
        subject.stub(:code).and_return "+"
        subject.should_receive(:increase).once
        subject.run
      end
      it "converts - into decrease" do
        subject.stub(:code).and_return "-"
        subject.should_receive(:decrease).once
        subject.run
      end
      it "converts , into get_character" do
        subject.stub(:code).and_return ","
        subject.should_receive(:get_character).once
        subject.run
      end
      it "converts . into stdout.print" do
        subject.stub(:code).and_return "."
        output = double('output')
        subject.should_receive(:stdout).once.and_return(output)
        subject.should_receive(:current).once.and_return(117)
        output.should_receive(:print).once

        subject.run
      end
    end

  end
end
