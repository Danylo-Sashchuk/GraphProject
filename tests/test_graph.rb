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
    assert_equal([], @graph.get_nodes)
    assert_equal([], @graph.get_edges)
    assert_node_and_edge_counts
  end

  def test_add_node1
    @graph.add_node(:a)
    assert_equal([:a], @graph.get_nodes)
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_node2
    @graph.add_node(:b)
    assert_equal([:b], @graph.get_nodes)
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_node3
    @graph.add_node(:a)
    @graph.add_node(:b)
    @graph.add_node(:c)
    assert(Util.arrays_equal_disregard_order(%i[a b c], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 3 })
  end

  def test_add_node_existed
    @graph.add_node(:a)
    assert_raises(ArgumentError) { @graph.add_node(:a) }
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_node_as_node1
    @graph.add_node(Node.new(:c))
    assert_equal([:c], @graph.get_nodes)
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_node_existed_as_node1
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(Node.new(:c)) }
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_node_existed_as_node2
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(:c) }
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_nodes1
    @graph.add_nodes(:a)
    assert(Util.arrays_equal_disregard_order(%i[a], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 1 })
  end

  def test_add_nodes2
    @graph.add_nodes(:a, :b, :c)
    assert(Util.arrays_equal_disregard_order(%i[a b c], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 3 })
  end

  def test_add_nodes3
    @graph.add_nodes(:b, :a, :c)
    assert(Util.arrays_equal_disregard_order(%i[a b c], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 3 })
  end

  def test_add_nodes4
    @graph.add_nodes(:a, :b, Node.new(:c)) #TODO: can we add node? if can. fix in add_nodes
    assert(Util.arrays_equal_disregard_order([], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 0 })
  end

  # TODO: Util.arrays_equal_disregard_order meke this method with assertion to convinient framework work

  def test_add_nodes_existed
    assert_raises(GraphException) { @graph.add_nodes(:a, :b, Node.new(:b)) }
    assert(Util.arrays_equal_disregard_order([], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 0 })
  end

  def test_add_nodes_wrong_type
    assert_raises(TypeError) { @graph.add_nodes(:a, Node.new(-1)) }
    assert(Util.arrays_equal_disregard_order([], @graph.get_nodes))
    assert_node_and_edge_counts({ nodes: 0 })
  end

  def test_add_edge
    add_many_nodes
    @graph.add_edge(:a, :b)
  end

  private

  def add_many_nodes
    @graph.add_nodes(:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o)
  end

  def assert_node_and_edge_counts(args = {})
    assert_node_counts(args[:nodes] || 0)
    assert_edge_counts(args[:edges] || 0)
  end

  def assert_node_counts(size)
    assert_equal(size, @graph.nbr_nodes)
  end

  def assert_edge_counts(size)
    assert_equal(size, @graph.nbr_edges)
  end
end
