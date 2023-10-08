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
    node = create_node(node)
    raise ArgumentError, "Node #{node} is already in the graph" if @nodes.include?(node)

    @nodes << node
  end

  def add_nodes(*nodes)
    added_nodes = Set.new
    begin
      nodes.each do |node|
        node = create_node(node)
        add_node(node)
        added_nodes.add(node)
      end
    rescue StandardError => e
      remove_added_nodes(added_nodes)
      raise GraphException.new(e), "Exception occurred. Rollback the graph's nodes."
    end
  end

  def get_nodes
    nodes.map(&:name)
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

  private

  def remove_added_nodes(added_nodes)
    @nodes -= added_nodes
  end

  def create_node(node)
    node.is_a?(Node) ? node : Node.new(node)
  end
end
