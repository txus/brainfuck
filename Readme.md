# brainfuck

Just another Brainfuck interpreter in Ruby!
(If you don't know what Brainfuck is, you definitely
[should](http://en.wikipedia.org/wiki/Brainfuck)).

This interpreter works with MRI 1.8.7, 1.9.2 and JRuby 1.5.5.

## UPDATE: Known caveats solved since 0.1.0!

Thanks to a complete rewrite using Kaspar Schiess' `parslet` (which you should
definitely [check it out](http://github.com/kschiess/parslet)) nested loops
work flawlessly. So yes, you can now run that high-security online payment
system you wrote in Brainfuck :)

## Installation and usage

You just `gem install brainfuck` (or `gem 'brainfuck'` in your Gemfile)!

And then: `brainfuck my_file.bf`

You can also require the gem and use inline brainfuck in your ruby scripts like this:

    require 'brainfuck'

    Brainfuck.run "+++>+++<---"
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
