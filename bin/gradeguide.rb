#!/usr/bin/env ruby

require 'optparse'
require 'CSV'

options = {}
optparse = OptionParser.new { |opts|
  opts.banner = "Usage: #{$0} [options] <file>"
}.parse!


all = Hash.new(0)

ARGF.each_line do |line|
  m = line.match(/^%([A-Z]+)%/)
  if m and m[1] != "TOTAL" then
    all[m[1]] += 1
  end
end


CSV::Writer.generate($stdout) { |csv|
  all.sort.each { |key,val|
    csv << [key, val, nil]
  }
}









