#!/usr/bin/env ruby

class Node
  attr_reader :value, :edges

  def initialize(value)
    @value = value
    @edges = []
  end

  def attach(node)
    self.edges << node
  end

  def leaves
    return [self] if edges.empty?

    edges.map(&:leaves).flatten.uniq
  end
end

current_line = []
previous_line = []
trailheads = []

trailmap = File.readlines('input.txt', chomp: true).map do |line|
  line.chars.map(&:to_i)
end.each do |line| 
  line.each_with_index do |v, i|
    node = Node.new(v)

    poss = current_line.last
    if poss && (poss.value - node.value).abs == 1
      poss.attach(node) if poss.value < node.value
      node.attach(poss) if node.value < poss.value
    end
    poss = previous_line[i]
    if poss && (poss.value - node.value).abs == 1
      poss.attach(node) if poss.value < node.value
      node.attach(poss) if node.value < poss.value
    end

    current_line << node
    trailheads << node if node.value == 0
  end
  previous_line = current_line
  current_line = []
end

puts trailheads.map(&:leaves).flatten.count { _1.value == 9 }
