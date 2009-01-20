require 'rake'
require 'rake/testtask'
begin
  require 'hanna/rdoctask'
rescue LoadError
  require 'rake/rdoctask'
end

require 'rcov/rcovtask'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "deliciousr"
    s.summary = "Ruby library for the del.icio.us API"
    s.email = "josh@technicalpickles.com"
    s.homepage = "http://github.com/technicalpickles/deliciousr"
    s.authors = ["Josh Nichols"]
    s.files =  FileList["[A-Z]*", "{bin,generators,lib,test}/**/*"]
    s.add_dependency 'happymapper'
  end
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end


Rake::TestTask.new do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'deliciousr'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Rcov::RcovTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task :default => :rcov
