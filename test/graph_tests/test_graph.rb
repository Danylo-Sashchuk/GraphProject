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

  def test_to_s1
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:b, :c)
    exp = "a -> b\nb -> a, c\nc -> b\n"
    assert_equal(exp, @graph.to_s)
  end

  def test_to_s2
    assert_equal('', @graph.to_s)
  end

  def test_to_s3
    add_some_nodes
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    @graph.add_edge(:a, :e)
    @graph.add_edge(:b, :j)
    assert_equal("a -> b, c, e\nb -> a, j\nc -> a\nd -> \ne -> a\nf -> \ng -> \nh -> \ni -> \nj -> b\nk -> \nl -> \nm -> \nn -> \no -> \n", @graph.to_s)
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
