# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../model/graph'
require_relative '../../utils/util'

class TestAssignmentTranscriptTest < Minitest::Test
  attr_reader :graph

  def test_paper
    @graph = Graph.new
    check_state

    @graph.add_node :a
    check_state({ nodes: [:a], nodes_nbr: 1 })

    @graph.add_nodes(%i[b c])
    check_state({ nodes: %i[a b c], nodes_nbr: 3 })

    assert_equal('[:a, :b, :c]', @graph.nodes_str)
    check_state({ nodes: %i[a b c], nodes_nbr: 3 })

    @graph.add_edge(:a, :b)
    @graph.add_edge(:b, :c)

    check_state({ nodes: %i[a b c], nodes_nbr: 3, edges: [%i[a b], %i[b c]], edges_nbr: 2 })
    assert_equal('[[:a, :b], [:b, :c]]', @graph.edges_str)

    assert_equal("a -> b\nb -> a, c\nc -> b\n", @graph.to_s)
  end

  private

  def check_state(args = {})
    assert_node_and_edge_number(args)
    assert_nodes_and_edges(args)
  end

  def assert_node_and_edge_number(args = {})
    assert_node_counts(args[:nodes_nbr] || 0)
    assert_edge_counts(args[:edges_nbr] || 0)
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
