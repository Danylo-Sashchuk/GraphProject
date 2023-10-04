# frozen_string_literal: true

class Edge
  attr_reader :node_a, :node_b

  def initialize(node_a, node_b)
    if node_a.is_a?(Symbol) && node_b.is_a?(Symbol)
      @node_a = Node.new(node_a)
      @node_b = Node.new(node_b)
    elsif node_a.is_a?(Node) && node_b.is_a?(Node)
      @node_a = node_a
      @node_b = node_b
    else
      raise ArgumentError, "Nodes must be either symbols or Nodes, but received #{node_a.class} and #{node_b.class}"
    end
  end

  def ==(other)
    return false unless other.is_a?(Edge)

    (@node_a == other.node_a && @node_b == other.node_b) ||
      (@node_a == other.node_b && @node_b == other.node_a)
  end

  def to_s
    "[#{@node_a}, #{@node_b}]"
  end
end
