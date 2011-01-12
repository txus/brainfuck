require 'spec_helper'

module Brainfuck
  describe Stack do

    describe "#current" do
      it 'returns the current value of the stack' do
        subject.current.should == 0
      end
    end

    describe "#fwd" do
      it 'advanced the pointer' do
        subject.fwd
        subject.instance_variable_get(:@pointer).should == 1
      end
    end

    describe "#bwd" do
      it 'decreases the pointer' do
        subject.instance_variable_set(:@pointer, 4)
        subject.bwd
        subject.instance_variable_get(:@pointer).should == 3
      end
      context "if the pointer is trying to get below zero" do
        it 'raises' do
          subject.instance_variable_set(:@pointer, 0)
          expect {
            subject.bwd
          }.to raise_error(RuntimeError, "Tried to access cell -1.")
        end
      end
    end

    describe "#inc" do
      it 'increases the current cell' do
        subject.instance_variable_set(:@stack, [4])
        subject.inc
        subject.current.should == 5
      end
    end

    describe "#dec" do
      it 'decreases the current cell' do
        subject.instance_variable_set(:@stack, [4])
        subject.dec
        subject.current.should == 3
      end
    end

    describe "#puts" do
      it 'prints the current character' do
        subject.stub_chain('current.chr').and_return 'A'
        $stdout.should_receive(:print).with 'A'
        subject.puts
      end
    end

    describe "#gets" do
      it 'prints the current character' do
        subject.should_receive(:get_character).and_return 97
        subject.gets
        subject.current.should == 97
      end
    end

    describe "#to_a" do
      it 'returns the stack array' do
        subject.to_a.should == [0]
      end
    end

    describe "#clear" do
      it 'clears the stack' do
        subject.should_receive(:initialize)
        subject.clear
      end
    end

  end
end
