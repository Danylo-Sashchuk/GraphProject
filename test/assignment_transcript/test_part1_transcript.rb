# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../model/graph'
require_relative '../utils/utils'

class TestPart1Transcript < Minitest::Test
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_paper
    assert(check_state)

    @graph.add_node :a
    assert(check_state({ nodes: [:a], nodes_nbr: 1 }))

    @graph.add_nodes(%i[b c])
    assert(check_state({ nodes: %i[a b c], nodes_nbr: 3, graph: @graph }))

    assert_equal('[:a, :b, :c]', @graph.nodes_str)
    assert(check_state({ nodes: %i[a b c], nodes_nbr: 3, graph: @graph }))

    @graph.add_edge(:a, :b)
    @graph.add_edge(:b, :c)

    assert(check_state({ nodes: %i[a b c], nodes_nbr: 3, edges: [%i[a b], %i[b c]], edges_nbr: 2 }))
    assert_equal('[[:a, :b], [:b, :c]]', @graph.edges_str)

    assert_equal("a -> b\nb -> a, c\nc -> b\n", @graph.to_s)
  end

  private

  def check_state(args = {})
    args[:graph] = @graph
    Utils.check_state(args)
  end
end
