# frozen_string_literal: true

require_relative 'edge'
require_relative '../exceptions/graph_exception'

class Graph
  # TODO: consider implementation of to_s through to_a
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

  # TODO: what about Array in parameter?
  def add_nodes(*nodes)
    added_nodes = Set.new
    begin
      nodes.each do |node|
        node = Node.ensure_node(node)
        add_node(node)
        added_nodes.add(node)
      end
    rescue StandardError => e
      remove_added_nodes(added_nodes)
      raise GraphException, "Exception occurred. Rollback the graph's nodes. \n#{e.message}"
    end
  end

  def get_nodes
    @nodes.map(&:name)
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

  def get_edges
    @edges
  end

  def nbr_edges
    @edges.size
  end

  private

  def remove_added_nodes(added_nodes)
    @nodes -= added_nodes
  end
end
