# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'test_graph'

class TestGraphEdges < TestGraph

  def test_get_edges1
    check_state
  end

  def test_get_edges2
    @graph.add_nodes(:a, :b)
    @graph.add_edge(:a, :b)
    check_state({ nodes_nbr: 2, edges_nbr: 1, nodes: %i[b a], edges: [%i[b a]] })
  end

  def test_add_edge1
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
    check_state
  end

  def test_add_edge2
    @graph.add_node(:a)
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
    check_state({ nodes: [:a], nodes_nbr: 1 })
  end

  def test_add_edge3
    @graph.add_node(:b)
    assert_raises(GraphException) { @graph.add_edge(:a, :b) }
    check_state({ nodes: [:b], nodes_nbr: 1 })
  end

  def test_add_edge4
    @graph.add_nodes(:a, :b)
    @graph.add_edge(:a, :b)
    check_state({ nodes: %i[a b], nodes_nbr: 2, edges_nbr: 1, edges: [%i[a b]] })
  end

  def test_add_edge5
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    check_state({ nodes: %i[a b c], nodes_nbr: 3, edges_nbr: 2, edges: [%i[a b], %i[c a]] })
  end

  def test_add_edge6
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    refute Utils.check_state({ nodes_nbr: 3, nodes: %i[a b c], edges_nbr: 2, edges: [%i[a b], %i[c a q]] })
  end

  def test_add_edge7
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    refute Utils.check_state({ nodes_nbr: 3, nodes: %i[a b c], edges_nbr: 2, edges: [%i[a b], %i[c a], %i[q w]] })
  end

  def test_edges_str1
    assert_equal('[]', @graph.edges_str)
    check_state
  end

  def test_edges_str2
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    assert_equal('[[:a, :b], [:a, :c]]', @graph.edges_str)
    check_state({ nodes_nbr: 3, nodes: %i[a b c], edges_nbr: 2, edges: [%i[a b], %i[c a]] })
  end

  def test_edges_str3
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :c)
    assert_equal('[[:a, :c]]', @graph.edges_str)
    check_state({ nodes_nbr: 3, nodes: %i[a b c], edges_nbr: 1, edges: [%i[c a]] })
  end
end
