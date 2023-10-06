# frozen_string_literal: true

require_relative 'edge'

class Graph
  attr_reader :nodes, :edges

  def initialize
    @nodes = Set.new
    @edges = Set.new
  end

  def add_node(node)
    raise ArgumentError if @nodes.include?(node)

    @nodes << if node.is_a?(Node)
                node
              else
                Node.new(node)
              end
  end

  def add_nodes(*nodes)
    nodes.each { |node| add_node(node) }
  end

  def get_nodes
    output = []
    nodes.each { |node| output << node.name }
    output
  end

  def nbr_nodes
    @nodes.size
  end

  def add_edge(node_a, node_b)
    edges << Edge.new(node_a, node_b)
  end

  def get_edges
    @edges
  end

  def nbr_edges
    @edges.size
  end
end
