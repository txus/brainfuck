# brainfuck

Just another Brainfuck interpreter in Ruby!
(If you don't know what Brainfuck is, you definitely
[should][http://en.wikipedia.org/wiki/Brainfuck]).

This interpreter works with MRI 1.8.7, 1.9.2 and JRuby 1.5.5.

## Known caveats (yes, before anything)

Ok, I admit it. Nested loops don't work in an extremely reliable manner, so to
speak. I suggest you NOT TO USE THIS IN PRODUCTION APPS. Yes, forget about
using this interpreter for that high-security online payment system you wrote in Brainfuck.

Oh and why are nested loops tricky with this interpreter? I was tired and Civilization 5
was installed in my laptop and... You know, forks and pull requests are always welcome! :)

## Installation and usage

You just `gem install brainfuck`!

And then: `brainfuck my_file.bf`

You can also require the gem and use inline brainfuck in your ruby scripts like this:

    require 'brainfuck'

    interpreter = Brainfuck::Interpreter.new
    interpreter.compile "+++>+++<---"

    interpreter.cells
    # => [0, 3]

It's very basic, and needs *a lot* of refactoring, but for now... there you go! ;)

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

Copyright (c) 2010 Josep M. Bach. See LICENSE for details.
