# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "brainfuck/version"

Gem::Specification.new do |s|
  s.name        = "brainfuck"
  s.version     = Brainfuck::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Josep M. Bach"]
  s.email       = ["josep.m.bach@gmail.com"]
  s.homepage    = "http://github.com/txus/brainfuck"
  s.summary     = %q{An implementation of Brainfuck on the Rubinius VM.}
  s.description = %q{An implementation of Brainfuck on the Rubinius VM.}

  s.rubyforge_project = "brainfuck"

  s.add_runtime_dependency "parslet"

  s.add_development_dependency "minitest"
  s.add_development_dependency "mocha"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
