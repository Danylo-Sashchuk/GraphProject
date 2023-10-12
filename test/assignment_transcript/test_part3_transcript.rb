# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../utils/graph_utils'
require_relative '../utils/utils'

class TestPart3Transcript < Minitest::Test
  def test_paper
    @graph = GraphUtils.genCompleteGraph(18)
    @graph.render('complete_18_nodes_for_tests_compare', [400, 400], 200, 'test/resources')

    assert Utils.svg_files_equal?('test/resources/complete_18_nodes_for_tests.svg', 'test/resources/complete_18_nodes_for_tests_compare.svg')
  end

  def check_state(args = {})
    args[:graph] = @graph
    assert(Utils.check_state(args))
  end
end
