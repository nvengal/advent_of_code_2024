#!/usr/bin/env ruby

captures = File.readlines("input.txt", chomp: true).map do |line|
  line.scan(/(mul\(\d+,\d+\))/).flatten
end.flatten

puts captures.map { _1.scan(/(\d+),(\d+)/).first.map(&:to_i).reduce(&:*) }.sum
