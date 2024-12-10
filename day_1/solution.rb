#!/usr/bin/env ruby

# part 1

l1, l2 = [], []
File.readlines('input.txt', chomp: true).each do |line|
  a, b = line.split(/ +/)
  l1 << a.to_i
  l2 << b.to_i
end

puts l1.sort.zip(l2.sort).map { (_1[0] - _1[1]).abs }.sum

# part 2

freq = l2.each_with_object({}) do |loc, hits|
  hits[loc] ||= 0
  hits[loc] += 1
end

puts l1.map { (freq[_1] || 0) * _1 }.sum
