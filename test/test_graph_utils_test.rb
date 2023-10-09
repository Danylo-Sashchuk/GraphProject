# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../model/graph'
require_relative '../utils/graph_utils'

class TestGraphUtilsTest < Minitest::Test
  def test_generate_complete_graph1
    actual = GraphUtils.genCompleteGraph(0)
    assert_equal(actual, Graph.new)
  end
end
