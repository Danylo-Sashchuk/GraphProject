# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require_relative 'utils/utils'

class TestGraphUtils < Minitest::Test
  def test_gen_complete_graph1
    actual = GraphUtils.genCompleteGraph(0)
    assert_equal(actual, Graph.new)
  end

  def test_gen_complete_graph2
    actual = GraphUtils.genCompleteGraph(3, 1.0)

    graph = Graph.new
    graph.add_nodes(:v0, :v1, :v2)
    graph.add_edge(:v1, :v0)
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

  def test_df1
    graph = Graph.new
    graph.add_nodes(:v0, :v1, :v2, :v3, :v4, :v5)
    graph.add_edge(:v0, Node.new(:v5))
    graph.add_edge(Node.new(:v1), :v5)
    graph.add_edge(:v5, :v4)

    act_dfs_res = GraphUtils.dfs(graph, :v0)
    exp = %i[v0 v1 v5 v4]
    assert(Utils.arrays_equal_disregard_order(act_dfs_res, exp))
  end

  def test_df2
    graph = GraphUtils.genCompleteGraph(10, 0)
    dfs = GraphUtils.dfs(graph, :v5)
    assert_equal(dfs, [:v5])
  end

  def test_render
    20.times do |index|
      name = 'v'
      c = rand(200..1000)
      center = [c, c] # Random center within a range
      radius = rand(100..600) # Random radius within a range
      number_of_nodes = rand(3..20) # Random number of nodes within a range
      p = rand(0.1..0.9) # Random p value within a range

      graph = GraphUtils.genCompleteGraph(number_of_nodes, p)
      graph.render("#{name}#{index}.svg", center, radius)
    end
  end
end
