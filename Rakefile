require 'rake'

task :default => :build
task :build => :test

desc "Runs all tests"
task :test do
  Rake::Task['spec'].invoke
  Rake::Task['features'].invoke
end

desc "Run all rspec tests"
begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/**/*_spec.rb'
  end
rescue LoadError => e
  raise e
  task :spec do
    $stderr.puts "Please install rspec: `gem install rspec`"
  end
end

desc "Test all features"
begin
  require 'cucumber'
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features) do |t|
    if ENV['PROFILE']
      t.cucumber_opts = "--profile #{ENV['PROFILE']}"
    end
  end
rescue LoadError
  task :features do
    $stderr.puts "Please install cucumber: `gem install cucumber`"
  end
end

namespace :db do
  desc "Generates all the views, search indexes etc for CouchDB"
  task :prepare do
    require 'blinkbox/book'
    Blinkbox::Book.all.first
    Blinkbox::Book.design!
  end
end