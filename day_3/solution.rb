#!/usr/bin/env ruby

captures = File.readlines("input.txt", chomp: true).join
  .split(/do\(\)/)
  .map { _1.split(/don't\(\)/) }
  .map { _1[0].scan(/(mul\(\d+,\d+\))/).flatten }
  .flatten

puts captures.map { _1.scan(/(\d+),(\d+)/).first.map(&:to_i).reduce(&:*) }.sum
