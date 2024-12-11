#!/usr/bin/env ruby

class Grid
  attr_reader :grid
  def initialize(grid)
    @grid = grid
  end

  def matches
    (horizontal + vertical + diagonal).count { _1 == 'XMAS' }
  end

  private

  def horizontal
    [grid[0].join, grid[0].join.reverse]
  end

  def vertical
    return [] if grid.length != 4

    [one_vertical(0), one_vertical(0).reverse]
  end

  def diagonal
    return [] if grid.length != 4 || grid[0].length != 4

    a = grid[0][0] + grid[1][1] + grid[2][2] + grid[3][3]
    b = grid[0][-1] + grid[1][-2] + grid[2][-3] + grid[3][-4]
    [a, a.reverse, b, b.reverse]
  end

  def one_vertical(i)
    grid[0][i] + grid[1][i] + grid[2][i] + grid[3][i]
  end
end

grid = File.readlines('input.txt', chomp: true).map(&:chars)

matches = (0...grid.length).map do |i|
  (0...grid.first.length).map do |j|
    g1 = grid[i..(i+3)].map { _1[j..(j+3)] }
    Grid.new(g1).matches
  end
end.flatten

puts matches.sum
