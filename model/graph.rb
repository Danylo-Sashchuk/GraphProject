# frozen_string_literal: true

require_relative 'edge'
require_relative '../exceptions/graph_exception'
require 'set'

# TODO: check object Id of nodes
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

  def add_nodes(*nodes)
    added_nodes = []
    begin
      nodes.flatten.each do |node|
        node = Node.ensure_node(node)
        add_node(node)
        added_nodes << node
      end
    rescue StandardError => e
      # Rollback the graph if one of the received nodes is wrong
      added_nodes.each { |node| @adjacency_list.delete(node) }
      raise GraphException, "Exception occurred. Rollback the graph's nodes. \n#{e.message}"
    end
  end

  def nodes_str
    nodes = @adjacency_list.keys.map { |node| node.name }
    "[#{nodes.join(', ')}]"
  end

  def nbr_nodes
    @adjacency_list.keys.size
  end

  def nodes
    @adjacency_list.keys
  end

  def add_edge(node_a, node_b)
    node_a = Node.ensure_node(node_a)
    node_b = Node.ensure_node(node_b)

    raise GraphException, "#{node_a} does not belong to the graph." unless @adjacency_list.keys.include?(node_a)
    raise GraphException, "#{node_b} does not belong to the graph." unless @adjacency_list.keys.include?(node_b)

    @adjacency_list[node_a] << node_b
    @adjacency_list[node_b] << node_a
  end

  def edges_str
    raw_edges = edges.to_a
    output = raw_edges.map { |array| "[#{array[0]}, #{array[1]}]" }.join(', ')
    "[#{output}]"
  end

  def nbr_edges
    edges = 0
    @adjacency_list.each do |_node, neighbors|
      edges += neighbors.length
    end
    edges / 2
  end

  def edges
    edges = Set.new
    @adjacency_list.each do |node, neighbors|
      neighbors.each { |neighbor| edges << [node.name, neighbor.name].sort }
    end
    edges
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

    self_adjacency_set = adjacency_set
    other_adjacency_set = other.adjacency_set

    self_adjacency_set == other_adjacency_set
  end

  def adjacency_set
    set = {}
    @adjacency_list.each do |node, neighbors|
      set[node] = Set.new(neighbors)
    end
    set
  end
end
