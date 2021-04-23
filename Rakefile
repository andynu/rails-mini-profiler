# frozen_string_literal: true

require 'bundler/setup'

APP_RAKEFILE = File.expand_path('spec/dummy/Rakefile', __dir__)
load 'rails/tasks/engine.rake'
load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
rspec = RSpec::Core::RakeTask.new(:spec)
rspec.verbose = false

require 'rubocop/rake_task'
RuboCop::RakeTask.new

task default: %i[spec rubocop]