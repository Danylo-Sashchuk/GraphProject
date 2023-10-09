# frozen_string_literal: true

require_relative 'edge'
require_relative '../exceptions/graph_exception'
require 'set'

class Graph
  attr_reader :adjacency_list

  def initialize
    @adjacency_list = {}
  end

  def add_node(node)
    node = Node.ensure_node(node)
    raise ArgumentError, "Node #{node} is already in the graph" if @adjacency_list.keys.include?(node)

    @adjacency_list[node] = []
  end

  # def add_nodes(*nodes)
  #   added_nodes = Set.new
  #   begin
  #     nodes.flatten.each do |node|
  #       node = Node.ensure_node(node)
  #       add_node(node)
  #       added_nodes.add(node)
  #     end
  #   rescue StandardError => e
  #     remove_added_nodes(added_nodes)
  #     raise GraphException, "Exception occurred. Rollback the graph's nodes. \n#{e.message}"
  #   end
  # end

  def nodes_str
    output = @adjacency_list.keys.join(', ')
    "[#{output}]"
  end

  def nbr_nodes
    @adjacency_list.keys.size
  end

  def add_edge(node_a, node_b)
    node_a = Node.ensure_node(node_a)
    node_b = Node.ensure_node(node_b)
    unless @adjacency_list.keys.include?(node_a) && @adjacency_list.keys.include?(node_b)
      raise GraphException, 'One of the nodes does not belong to the graph.'
    end

    @adjacency_list[node_a] << node_b
    @adjacency_list[node_b] << node_a
  end

  def edges_str
    edges = Set.new
    @adjacency_list.each do |node, neighbors|
      neighbors.each { |neighbor| edges << [node.name, neighbor.name].sort }
    end
    edges.to_a.to_s
  end

  def nbr_edges
    edges = 0
    @adjacency_list.each do |_node, neighbors|
      edges += neighbors.length
    end
    edges / 2
  end

  def to_s
    result = ''
    adjacency_list.each do |node, neighbors|
      result += "#{node} -> #{neighbors.join(', ')}\n"
    end
    result
  end

  def ==(other)
    return false unless other.is_a?(Graph)

    @adjacency_list == other.adjacency_list
  end

  private

  # def remove_added_nodes(added_nodes)
  #   @nodes -= added_nodes
  # end
end
