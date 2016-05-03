#
# spec_helper.rb
#
# Copyright (c) 2016 Kyle Schutt. All rights reserved.

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])
require 'crowdskout'
#require 'simplecov'

#SimpleCov.start

def load_file(file_name)
  json = File.read(File.join(File.dirname(__FILE__), 'fixtures', file_name))
end