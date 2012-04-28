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

totals = []
scores = []
late = nil

tagline = /^%([A-Z]+)%/

total = 0
open(ARGV[1]).each_line do |line|
  m = tagline.match(line)
  if m then
    if m[1] == "TOTAL" then
      puts "Total: " + total.to_s
      score = 100 + total
      if late then
        puts "Score: " + score.to_s + " * .8 = " + (score * 0.8).to_s
      else
        puts "Score: " + score.to_s
      end
      totals << total
      scores << score
        late = nil
      total = 0
    elsif m[1] == "LATE" then
      puts "** submitted late **"
      late = 1
    else
      total += mapping[m[1]]
      puts line.sub(tagline, mapping[m[1]].to_s)
    end
  else
    puts line
  end

end


p totals
p scores

