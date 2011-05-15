# brainfuck

An implementation of Brainfuck on the [Rubinius](http://rubini.us) VM.

(If you don't know what Brainfuck is, you definitely
[should](http://en.wikipedia.org/wiki/Brainfuck)).

Obviously... needs Rubinius!

## Installation and usage

You just `gem install brainfuck` (or `gem 'brainfuck'` in your Gemfile)!

And then: 

    $ brainfuck my_file.bf

Or if you just want to generate the compiled bytecode in `my_file.bfc`:

    $ brainfuck -C my_file.bf

You can also require the gem and use inline brainfuck in your ruby scripts like this:

    require 'brainfuck'

    # Brainfuck needs an object binding to do its stuff.
    bnd = Object.new
    def bnd.get; binding; end
    bnd = bnd.get

    Brainfuck::CodeLoader.execute_code "+++>+++<---", bnd, nil
    # => [0, 3]


## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add specs for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  If you want to have your own version, that is fine but bump version
  in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2011 Josep M. Bach. See LICENSE for details.
