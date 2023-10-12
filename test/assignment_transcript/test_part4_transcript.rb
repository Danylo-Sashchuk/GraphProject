# frozen_string_literal: true

require 'minitest/autorun'

class TestPart4Transcript < Minitest::Test
  def test_paper
    graph = Graph.new
    graph.add_nodes(:a, :b, :c, :d, :e, :f, :q, :t, :p)
    graph.add_edge :a, :b
    graph.add_edge :a, :c
    graph.add_edge :c, :e
    graph.add_edge :f, :d
    graph.add_edge :q, :t
    graph.add_edge :p, :t
    graph.add_edge :p, :q

    dfs = GraphUtils.dfs(graph, :t)
    assert Utils.arrays_equal_disregard_order(dfs, %i[t p q])
  end
end
