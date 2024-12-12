#!/usr/bin/env ruby

@memo = {}

def blink(val, num)
  @memo[val] ||= []
  return 1 if num == 0
  return @memo[val][num] if @memo[val][num]

  if val == '0'
    @memo[val][num] = blink('1', num - 1)
  elsif val.length.even?
    @memo[val][num] =
      blink(val[...(val.length/2)], num - 1) +
      blink(val[(val.length/2)..].to_i.to_s, num - 1)
  else
    @memo[val][num] = blink((val.to_i * 2024).to_s, num - 1)
  end
end

stones = File.readlines("input.txt", chomp: true)[0].split(" ")

puts "25: " + stones.map { blink(_1, 25) }.sum.to_s
puts "75: " + stones.map { blink(_1, 75) }.sum.to_s
