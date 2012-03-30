#!/usr/bin/env ruby

require 'optparse'
require 'csv'

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options] <map> <file>"
end

optparse.parse!

if ARGV.length < 2 then
  optparse.warn("two arguments required.")
  puts optparse.help
  exit -1
end

mapping = Hash.new

CSV.foreach(ARGV[0]) { |data|
  mapping[data[0]] = data[2].to_i
}

total = 0

tagline = /^%([A-Z]+)%/

open(ARGV[1]).each_line do |line|
  m = tagline.match(line)
  if m then
    if m[1] == "TOTAL" then
      puts "Total: " + total.to_s
    else
      total += mapping[m[1]]
    end
  else
    puts line
  end

end

p mapping

