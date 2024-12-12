#!/usr/bin/env ruby

lines = File.readlines('input.txt', chomp: true)

@rules = lines.select { _1.include?("|") }.map.with_object({}) do |rule, memo|
  x, y = rule.split("|")
  memo[x] ||= []
  memo[x] << y
end

def correct?(pages)
  pages.each.with_index.all? do |p, i|
    rule = @rules[p]
    next true unless rule

    rule.none? { pages[...i].include?(_1) }
  end
end

def next_rule(pages)
  pages.each.with_index do |p, i|
    rule = @rules[p]
    next unless rule

    r = rule.find { pages[...i].include?(_1) }
    next unless r

    return [pages.index(r), i]
  end
end

books = lines
  .select { _1.include?(",") }
  .select { correct?(_1.split(",")) }

puts books.map { _1.split(",") }.map { _1[_1.length/2].to_i }.sum

incorrect_books = lines
  .select { _1.include?(",") }
  .reject { correct?(_1.split(",")) }

fixed = incorrect_books.map do |book|
  pages = book.split(",")
  while !correct?(pages)
    a, b = next_rule(pages)
    pages[a], pages[b] = pages[b], pages[a]
  end
  pages
end

puts fixed.map { _1[_1.length/2].to_i }.sum
