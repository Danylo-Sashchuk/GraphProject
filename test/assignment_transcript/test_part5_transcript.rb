# frozen_string_literal: true

require 'minitest/autorun'

class TestPart5Transcript < Minitest::Test
  def test_paper
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
                                  'test/resources/three_graphs_for_tests_transcript.svg')
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
end
