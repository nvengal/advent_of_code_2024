#!/usr/bin/env ruby

stones = File.readlines("input.txt", chomp: true)[0].split(" ")

25.times do
  stones = stones.map do |stone|
    next '1' if stone == '0'

    if stone.length.even?
      next [
        stone[...(stone.length/2)],
        stone[(stone.length/2)..].to_i.to_s
      ]
    end

    (stone.to_i * 2024).to_s
  end.flatten
end

puts stones.count
