#!/usr/bin/env ruby

lines = File.readlines('input.txt', chomp: true)

rules = lines.select { _1.include?("|") }.map.with_object({}) do |rule, memo|
  x, y = rule.split("|")
  memo[x] ||= []
  memo[x] << y
end

books = lines
  .select { _1.include?(",") }
  .select do |book|
    pages = book.split(",")
    pages.each.with_index.all? do |p, i|
      rule = rules[p]
      next true unless rule

      rule.none? { pages[...i].include?(_1) }
    end
  end
puts books.map { _1.split(",") }.map { _1[_1.length/2].to_i }.sum