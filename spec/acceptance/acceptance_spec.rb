require 'spec_helper'

module Brainfuck
  describe "Acceptance specs" do

    subject { Brainfuck }

    describe "without loops nor user input" do
      let(:code) do
        <<-EOS
          ++++>++++---.<--.
        EOS
      end
      it "sets two cells to 2 and 1" do
        subject.run(code).should == [2,1]
      end
      it "prints 2 and 1" do
        $stdout.should_receive(:print).twice
        subject.run code
      end
    end

    describe "with user input" do
      let(:code) do
        <<-EOS
          ,++++
        EOS
      end
      it "sets the first cell to a + 4" do
        stack = Stack.new
        Interpreter.stub(:stack).and_return stack

        stack.should_receive(:get_character).once.and_return 97

        subject.run(code).should == [101]
      end
    end

    describe "with loops" do
      let(:code) do
        <<-EOS
          ++++[-]+-+
        EOS
      end
      it "runs the loop 4 times" do
        subject.run(code).should == [1]
      end
    end
    
    describe "cell hopping examples" do

      it "transfers the content from one cell to another" do
        subject.run("++++++++++      [>+<-]").should == [0,10]
      end

      it "transfers the content from one cell to the third" do
        subject.run("++++++++++      [>+<-]>[>+<-]").should == [0,0,10]
      end

      it "transfers the content from one cell to the third and back to the second" do
        subject.run("++++++++++      [>+<-]>[>+<-]>[<+>-]").should == [0,10,0]
      end

    end

    describe "nested loop examples" do

      it "work flawlessly" do
        subject.run("[++++++++++[-]+-+-]").should == [0]
      end

    end

    describe "hello world" do

      it "displays hello world" do
        subject.run <<-EOS
          +++++ +++++            
          [                      
              > +++++ ++         
              > +++++ +++++      
              > +++              
              > +                
              <<<< -              
          ]                   
          > ++ .                  
          > + .                   
          +++++ ++ .              
          .                       
          +++ .                   
          > ++ .                  
          << +++++ +++++ +++++ .  
          > .                     
          +++ .                   
          ----- - .               
          ----- --- .             
          > + .                   
          > .                     
  EOS

      end
    end

  end
end
