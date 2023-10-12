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

  def test_render1
    graph = GraphUtils.genCompleteGraph(18)
    graph.render('complete_18_nodes_for_tests_compare', [400, 400], 200, 'test/resources')
    assert Utils.svg_files_equal?('test/resources/complete_18_nodes_for_tests.svg',
                                  'test/resources/complete_18_nodes_for_tests_compare.svg')

    assert(graph.nbr_nodes, 18)
    assert(graph.nbr_edges, 153)
  end

  def test_dfs_complete
    graph = GraphUtils.genCompleteGraph(15)
    dfs = GraphUtils.dfs(graph, :v1)
    assert Utils.arrays_equal_disregard_order(dfs, %i[v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12 v13 v14 v0])
  end

  def test_dfs_uncompleted
    graph = create_testable_graph
    dfs = GraphUtils.dfs(graph, Node.new(:a))
    assert Utils.arrays_equal_disregard_order(dfs, %i[a b c e])
  end

  def test_sub_graph1
    graph = create_testable_graph
    dfs = GraphUtils.dfs(graph, :p)
    sub_graph_p = GraphUtils.genSubGraph(graph, dfs)
    check_state({ graph: sub_graph_p, nodes_nbr: 3, nodes: %i[p t q], edges_nbr: 3, edges: [%i[q t], %i[p t], %i[p q]] })
  end

  def test_sub_graph2
    graph = create_testable_graph
    dfs = GraphUtils.dfs(graph, :d)
    sub_graph_p = GraphUtils.genSubGraph(graph, dfs)
    check_state({ graph: sub_graph_p, nodes_nbr: 2, nodes: %i[d f], edges_nbr: 1, edges: [%i[d f]] })
  end

  def test_graphs_render
    graph = create_testable_graph
    graph.layout_circular([400, 400], 200)
    dfs = GraphUtils.dfs(graph, :p)
    sub_graph_p = GraphUtils.genSubGraph(graph, dfs)
    dfs = GraphUtils.dfs(graph, :d)
    sub_graph_d = GraphUtils.genSubGraph(graph, dfs)
    GraphUtils.render_graphs('three_graphs', [[graph, 'red', 'red'],
                                              [sub_graph_p, 'green', 'blue'],
                                              [sub_graph_d, 'purple', 'yellow']], './test/resources')
    assert Utils.svg_files_equal?('test/resources/three_graphs.svg',
                                  'test/resources/three_graphs_for_tests.svg')
  end

  def create_testable_graph
    graph = Graph.new
    graph.add_nodes(:a, :b, :c, :d, :e, :f, :q, :t, :p)
    graph.add_edge :a, :b
    graph.add_edge :a, :c
    graph.add_edge :c, :e
    graph.add_edge :f, :d
    graph.add_edge :q, :t
    graph.add_edge :p, :t
    graph.add_edge :p, :q
    graph
  end

  def check_state(args = {})
    args[:args] = Graph.new if args[:graph].nil?
    assert(Utils.check_state(args))
  end
end
