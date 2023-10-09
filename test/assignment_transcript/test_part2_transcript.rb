# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../utils/graph_utils'
require_relative '../utils/utils'

class TestPart2Transcript < Minitest::Test
  def test_paper
    @graph = GraphUtils.genCompleteGraph(3)
    check_state({ nodes_nbr: 3, nodes: %i[v0 v1 v2], edges_nbr: 3, edges: [%i[v0 v1], %i[v0 v2], %i[v1 v2]] })

    @graph = GraphUtils.genCompleteGraph(5)
    assert(@graph.nbr_nodes, 5)
    assert(@graph.nbr_edges, 10)
  end

  def check_state(args = {})
    args[:graph] = @graph
    assert(Utils.check_state(args))
  end
end
