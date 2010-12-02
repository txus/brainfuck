require 'spec_helper'

module Brainfuck
  describe Interpreter, "acceptance specs" do

    describe "without loops nor user input" do
      let(:code) do
        <<-EOS
          ++++>++++---.<--.
        EOS
      end
      it "sets two cells to 2 and 1" do
        subject.should_receive(:code).and_return code
        subject.compile(code)
        subject.cells.should == [2,1]
      end
      it "prints 2 and 1" do
        output = double('output')
        subject.should_receive(:stdout).twice.and_return(output)
        output.should_receive(:print).with(1.chr).ordered
        output.should_receive(:print).with(2.chr).ordered

        subject.compile(code)
      end
    end

    describe "with user input" do
      let(:code) do
        <<-EOS
          ,++++
        EOS
      end
      it "sets the first cell to a + 4" do
        input = double('input')
        subject.should_receive(:get_character).once.and_return 97

        subject.compile(code)
        subject.current.should == 101
      end
    end

    describe "with loops" do
      let(:code) do
        <<-EOS
          ++++[-]+-+
        EOS
      end
      it "runs the loop 4 times" do
        subject.compile(code)
        subject.current.should == 1
      end
    end
    
    describe "cell hopping examples" do

      it "transfers the content from one cell to another" do
        subject.cells = [10]
        subject.compile("[>+<-]")
        subject.cells.should == [0,10]
      end

      it "transfers the content from one cell to the third" do
        subject.cells = [10]
        subject.compile("[>+<-]>[>+<-]")
        subject.cells.should == [0,0,10]
      end

      it "transfers the content from one cell to the third and back to the second" do
        subject.cells = [10]
        subject.compile("[>+<-]>[>+<-]>[<+>-]")
        subject.cells.should == [0,10,0]
      end

    end

    describe "hello world" do

      it "displays hello world" do
        subject.compile <<-EOS
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
