# frozen_string_literal: true

require_relative 'node'
require 'set'

class Edge
  attr_reader :nodes

  def initialize(node_a, node_b)
    @nodes = Set.new
    [node_a, node_b].each do |node|
      if node.is_a?(Symbol)
        @nodes << Node.new(node)
      elsif node.is_a?(Node)
        @nodes << node
      else
        raise ArgumentError, "Nodes must be either symbols or Nodes, but received #{node.class}"
      end
    end
  end

  def ==(other)
    return false unless other.is_a?(Edge)

    @nodes == other.nodes
  end

  def to_s
    "[#{nodes.to_a.join(', ')}]"
  end
end
