# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'test_graph'

class TestGraphEdges < TestGraph

  def test_get_edges1
    assert_nodes_and_edges
    assert_node_and_edge_number
  end

  def test_get_edges2
    @graph.add_nodes(:a, :b)
    @graph.add_edge(:a, :b)
    assert_node_and_edge_number({ nodes: 2, edges: 1 })
    assert_nodes_and_edges({ nodes: %i[b a], edges: [%i[b a]] })
  end

  def test_get_edges3
    add_some_nodes
    @graph.add_edge(:a, :b)
  end

  def test_add_edge1
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
  end

  def test_add_edge2
    @graph.add_node(:a)
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
  end

  def test_add_edge3
    @graph.add_node(:b)
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
  end

  def test_add_edge4
    @graph.add_nodes(:a, :b)
    @graph.add_edge(:a, :b)
    assert_node_and_edge_number({ nodes: 2, edges: 1 })
    assert_nodes_and_edges({ nodes: %i[a b], edges: [%i[a b]] })
  end

  def test_add_edge5
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    assert_node_and_edge_number({ nodes: 3, edges: 2 })
    assert_nodes_and_edges({ nodes: %i[a b c], edges: [%i[a b], %i[c a]] })
  end

  def test_add_edge6
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    assert_node_and_edge_number({ nodes: 3, edges: 2 })
    refute Util.arrays_equal_disregard_order([%i[a b], %i[c a q]], @graph.edges)
  end

  def test_add_edge7
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    assert_node_and_edge_number({ nodes: 3, edges: 2 })
    refute Util.arrays_equal_disregard_order([%i[a b], %i[c a], %i[q w]], @graph.edges)
  end

  def test_edges_str1
    assert_equal('[]', @graph.edges_str)
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_edges_str2
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    assert_equal('[[:a, :b], [:a, :c]]', @graph.edges_str)
    assert_node_and_edge_number({ nodes: 3, edges: 2 })
    assert_nodes_and_edges({ nodes: %i[b a c], edges: [%i[a b], %i[c a]] })
  end

  def test_edges_str3
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :c)
    assert_equal('[[:a, :c]]', @graph.edges_str)
    assert_node_and_edge_number({ nodes: 3, edges: 1 })
    assert_nodes_and_edges({ nodes: %i[b a c], edges: [%i[c a]] })
  end

  def test_run_all_tests

  end
end
