#!/usr/bin/env ruby

class Node
  attr_reader :val, :edges
  def initialize(val)
    @val = val
    @edges = []
    @counted = false
  end

  def attach(node)
    return unless val == node&.val

    @edges << node
    node.edges << self
  end

  def counted?
    @counted
  end

  def count!
    @counted = true
  end

  def all
    @all ||= _all([self])
  end

  def _all(curr)
    edges.each do |e|
      next if curr.include?(e)

      curr << e
      e._all(curr)
    end

    curr
  end

  def count_all!
    all.each(&:count!)
  end

  def area
    all.count
  end

  def perimeter
    all.map { 4 - _1.edges.count }.sum
  end
end

plot = File.readlines('input.txt', chomp: true).map { _1.split('') }

plot = plot.map { |x| x.map { Node.new(_1) } }

(0...plot.length).each do |y|
  (0...plot.first.length).each do |x|
    curr = plot[y][x]
    curr.attach(plot[y+1][x]) if y+1 < plot.length
    curr.attach(plot[y][x+1])
  end
end

sum = plot.map do
  _1.map do |p|
    next 0 if p.counted?
    p.count_all!
    p.area * p.perimeter
  end
end.flatten

puts sum.sum
