# frozen_string_literal: true

class Utils

  def self.some_nodes
    %i[a b c d e f g h i j k l m n o] # 15
  end

  def self.check_state(args = {})
    assert_node_number(args) &&
      assert_edge_number(args) &&
      assert_nodes(args) &&
      assert_edges(args)
  end

  def self.arrays_equal_disregard_order(array_a, array_b)
    ((array_a.to_a - array_b.to_a) + (array_b.to_a - array_a.to_a)).empty?
  end

  def self.arrays_of_arrays_equal_disregard_order(array_of_array_a, array_of_array_b)
    return false unless array_of_array_a.length == array_of_array_b.length

    array_of_array_a.all? do |inner_array_a|
      array_of_array_b.any? do |inner_array_b|
        arrays_equal_disregard_order(inner_array_a, inner_array_b)
      end
    end
  end

  def self.assert_node_number(args = {})
    expected_nodes_nbr = args[:nodes_nbr] || 0
    graph_nodes_nbr = args[:graph]&.nbr_nodes || 0
    expected_nodes_nbr == graph_nodes_nbr
  end

  def self.assert_edge_number(args = [])
    expected_edges_nbr = args[:edges_nbr] || 0
    graph_edges_nbr = args[:graph]&.nbr_edges || 0
    expected_edges_nbr == graph_edges_nbr
  end

  def self.assert_nodes(args = {})
    expected_nodes = args[:nodes] || []
    graph_nodes = args[:graph]&.nodes&.map(&:name) || []
    arrays_equal_disregard_order(expected_nodes, graph_nodes)
  end

  def self.assert_edges(args = {})
    expected_edges = args[:edges] || []
    graph_edges = args[:graph]&.edges || []
    arrays_of_arrays_equal_disregard_order(expected_edges, graph_edges)
  end
end
