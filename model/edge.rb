# frozen_string_literal: true

require_relative 'node'
require 'set'

# Edge class represents an edge in a graph, connecting two nodes.
#
# An edge is defined by a pair of nodes, which can be instances of the `Node` class or symbols representing node names.
class Edge
  attr_reader :nodes

  def initialize(node_a, node_b)
    @nodes = Set.new
    [node_a, node_b].each do |node|
      @nodes << Node.ensure_node(node)
    end
  end

  def ==(other)
    other.is_a?(Edge) && @nodes == other.nodes
  end

  def to_s
    "[#{nodes.to_a.join(', ')}]"
  end

  def hash
    @nodes.hash
  end

  def eql?(other)
    other.is_a?(Edge) && self == other
  end
end
