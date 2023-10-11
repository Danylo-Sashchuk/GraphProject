# frozen_string_literal: true

# Node class represents a node in a graph, identified by a unique symbol name.
#
# Each node is created with a name, which must be a symbol. The name is used to
# uniquely identify the node within the graph.
class Node
  attr_reader :name

  def initialize(name)
    raise TypeError, "Node name must be a symbol, but received #{name.class}." unless name.is_a?(Symbol)

    @name = name
  end

  def to_s
    @name.to_s
  end

  def ==(other)
    other.is_a?(Node) && @name == other.name
  end

  def hash
    @name.hash
  end

  def eql?(other)
    other.is_a?(Node) && self == other
  end

  def self.ensure_node(node)
    node.is_a?(Node) ? node : Node.new(node)
  end
end
