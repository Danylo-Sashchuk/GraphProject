# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../model/graph'
require_relative '../../utils/util'

class TestGraph < Minitest::Unit::TestCase
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_initialize
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

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
