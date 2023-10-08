# frozen_string_literal: true

# Node class represents a node in a graph, identified by a unique symbol name.
#
# Each node is created with a name, which must be a symbol. The name is used to
# uniquely identify the node within the graph.
class Node
  attr_reader :name

  def initialize(name)
    if name.is_a?(Node)
      @name = name.name
    elsif name.is_a?(Symbol)
      @name = name
    else
      raise TypeError, "Node name must be a symbol, but received #{name.class}"
    end
  end

  def to_s
    @name.name
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
end
