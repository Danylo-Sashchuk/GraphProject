# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../graph'

class TestGraph < Minitest::Unit::TestCase
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_add_node1
    @graph.add_node(:a)
    assert_equal([:a], @graph.get_nodes)
  end

  def test_add_node2
    @graph.add_node(:b)
    assert_equal([:b], @graph.get_nodes)
  end

  def test_add_node_not_symbol
    assert_raises(TypeError) { @graph.add_node(4) }
  end
end
