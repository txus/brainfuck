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
  s.summary     = %q{Another Brainfuck interpreter in Ruby}
  s.description     = %q{Another Brainfuck interpreter in Ruby}

  s.rubyforge_project = "brainfuck"

  s.add_runtime_dependency "highline"
  s.add_development_dependency "rspec"
  s.add_development_dependency "bundler"
  s.add_development_dependency "simplecov"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
