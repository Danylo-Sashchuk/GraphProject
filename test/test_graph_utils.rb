# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../model/graph'
require_relative '../utils/graph_utils'

class TestGraphUtils < Minitest::Test
  def test_gen_complete_graph1
    actual = GraphUtils.genCompleteGraph(0)
    assert_equal(actual, Graph.new)
  end

  def test_gen_complete_graph2
    actual = GraphUtils.genCompleteGraph(3, 1.0)

    graph = Graph.new
    graph.add_nodes(:v0, :v1, :v2)
    graph.add_edge(:v0, :v1)
    graph.add_edge(:v1, :v2)
    graph.add_edge(:v2, :v0)

    expected_edges = 3 * (3 - 1) / 2

    assert_equal(expected_edges, graph.nbr_edges)
    assert_equal(graph, actual)
  end

  def test_gen_complete_graph3
    actual = GraphUtils.genCompleteGraph(5, 0.5)
    expected_edges = 5 * (5 - 1) / 2
    assert_operator(actual.nbr_edges, :>, 0)
    assert_operator(actual.nbr_edges, :<, expected_edges)
  end
end
