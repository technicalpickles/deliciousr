# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/deliciousr.rb'
require 'spec/rake/spectask'

Hoe.new('deliciousr', Deliciousr::VERSION) do |p|
  p.rubyforge_name = 'deliciousr'
  p.author = 'Josh Nichols'
  p.email = 'josh@technicalpickles.com'
  # p.summary = 'FIX'
  # p.description = p.paragraphs_of('README.txt', 2..5).join("\n\n")
  # p.url = p.paragraphs_of('README.txt', 0).first.split(/\n/)[1..-1]
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.test_globs = 'test/**/*_test.rb'
end

# vim: syntax=Ruby
