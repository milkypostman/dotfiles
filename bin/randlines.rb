#!/usr/bin/env ruby

require 'optparse'

version = [1,0,0]
options = {:number => 10}

OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] [filename]"

  opts.on("-nN", "--number N", OptionParser::DecimalInteger,
       "Number of lines to randomly select [10]") do |n|
    options[:number] = n
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  # Another typical switch to print the version.
  opts.on_tail("--version", "Show version") do
    puts version.join('.')
    exit
  end
end.parse!

puts ARGF.readlines.shuffle[0,options[:number]]




