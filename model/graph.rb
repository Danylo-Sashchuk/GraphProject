# frozen_string_literal: true

require_relative 'edge'
require_relative '../exceptions/graph_exception'

class Graph
  attr_reader :nodes, :edges

  def initialize
    @nodes = Set.new
    @edges = Set.new
  end

  def add_node(node)
    node = Node.ensure_node(node)
    raise ArgumentError, "Node #{node} is already in the graph" if @nodes.include?(node)

    @nodes << node
  end

  def add_nodes(*nodes)
    added_nodes = Set.new
    begin
      nodes.flatten.each do |node|
        node = Node.ensure_node(node)
        add_node(node)
        added_nodes.add(node)
      end
    rescue StandardError => e
      remove_added_nodes(added_nodes)
      raise GraphException, "Exception occurred. Rollback the graph's nodes. \n#{e.message}"
    end
  end

  def nodes_str
    @nodes.map(&:name).to_s
  end

  def nbr_nodes
    @nodes.size
  end

  def add_edge(node_a, node_b)
    node_a = Node.ensure_node(node_a)
    node_b = Node.ensure_node(node_b)
    unless @nodes.include?(node_a) && @nodes.include?(node_b)
      raise GraphException, 'One of the nodes does not belong to the graph.'
    end

    @edges << Edge.new(node_a, node_b)
  end

  def edges_str
    "[#{edges.join(', ')}]"
  end

  def nbr_edges
    @edges.size
  end

  def to_s
    adjacency_list = {}
    @nodes.each { |node| adjacency_list[node.name] = [] }

    edges.each do |edge|
      node1, node2 = edge.nodes.map(&:name)
      adjacency_list[node1] << node2
      adjacency_list[node2] << node1
    end

    result = ''
    adjacency_list.each do |node, neighbors|
      result += "#{node} -> #{neighbors.join(', ')}\n"
    end
    result
  end

  private

  def remove_added_nodes(added_nodes)
    @nodes -= added_nodes
  end
end
