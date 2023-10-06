# frozen_string_literal: true

require_relative 'node'
require 'set'

class Edge
  attr_reader :nodes

  def initialize(node_a, node_b)
    @nodes = Set.new
    [node_a, node_b].each do |node|
      @nodes << if node.is_a?(Node)
                  node
                else
                  Node.new(node)
                end
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