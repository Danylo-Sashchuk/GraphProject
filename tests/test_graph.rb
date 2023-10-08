# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../model/graph'
require_relative '../utils/util'

class TestGraph < Minitest::Unit::TestCase
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_initialize
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_add_node1
    @graph.add_node(:a)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_node2
    @graph.add_node(:b)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:b] })
  end

  def test_add_node3
    @graph.add_node(:a)
    @graph.add_node(Node.new(:b))
    @graph.add_node(:c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_node_existed
    @graph.add_node(:a)
    assert_raises(ArgumentError) { @graph.add_node(:a) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_node_as_node1
    @graph.add_node(Node.new(:c))
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_node_existed_as_node1
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(Node.new(:c)) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_node_existed_as_node2
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(:c) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_nodes1
    @graph.add_nodes(:a)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_nodes2
    @graph.add_nodes(:a, :b, :c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes3
    @graph.add_nodes(:b, :a, :c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes4
    @graph.add_nodes(:a, :b, Node.new(:c))
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes5
    @graph.add_nodes(%i[a c], %i[w q], :b, :t)
    assert_node_and_edge_number({ nodes: 6 })
    assert_nodes_and_edges({ nodes: %i[t a b c w q] })
  end

  def test_add_nodes_existed
    assert_raises(GraphException) { @graph.add_nodes(:a, :b, Node.new(:b)) }
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_add_nodes_wrong_type
    assert_raises(TypeError) { @graph.add_nodes(:a, Node.new(-1)) }
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_get_nodes1
    assert_nodes_and_edges
  end

  def test_get_nodes2
    @graph.add_nodes(Node.new(:a), :b)
    assert_node_and_edge_number({ nodes: 2 })
    assert_nodes_and_edges({ nodes: %i[a b] })
  end

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

  def test_nodes_str1
    assert_equal('[]', @graph.nodes_str)
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_nodes_str2
    @graph.add_nodes(:a, :b, :c)
    assert_equal('[:a, :b, :c]', @graph.nodes_str)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_nodes_str3
    @graph.add_nodes(:a, :c, :b)
    assert_equal('[:a, :c, :b]', @graph.nodes_str)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
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

  private

  def add_some_nodes
    @graph.add_nodes(:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o) # 15
  end

  def assert_node_and_edge_number(args = {})
    assert_node_counts(args[:nodes] || 0)
    assert_edge_counts(args[:edges] || 0)
  end

  def assert_node_counts(size)
    assert_equal(size, @graph.nbr_nodes)
  end

  def assert_edge_counts(size)
    assert_equal(size, @graph.nbr_edges)
  end

  def assert_nodes_and_edges(args = {})
    assert_nodes(args[:nodes] || [])
    assert_edges(args[:edges] || [])
  end

  def assert_nodes(expected)
    assert(Util.arrays_equal_disregard_order(expected, @graph.nodes.map(&:name)))
  end

  def assert_edges(expected)
    assert(Util.arrays_of_arrays_equal_disregard_order(expected, @graph.edges))
  end
end
