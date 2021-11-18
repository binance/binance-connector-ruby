# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

desc 'Release a new gem version'
task :release do
  sh('gem bump --file lib/binance/version.rb')
end
