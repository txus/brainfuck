require 'bundler'
Bundler::GemHelper.install_tasks

require 'simplecov'
SimpleCov.start do
  add_group "Lib", 'lib'
end

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec
