# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../model/graph'

class TestGraph < Minitest::Unit::TestCase
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_initialize
    assert_equal([], @graph.get_nodes)
  end

  def test_add_node1
    @graph.add_node(:a)
    assert_equal([:a], @graph.get_nodes)
  end

  def test_add_node2
    @graph.add_node(:b)
    assert_equal([:b], @graph.get_nodes)
  end

  def test_add_node_as_node
    @graph.add_node(Node.new(:c))
    assert_equal([:c], @graph.get_nodes)
  end

  def test_add_nodes1
    @graph.add_nodes(:a)
    assert_equal([:a], @graph.get_nodes)
  end

  def test_add_nodes2
    @graph.add_nodes(:a, :b, :c)
    assert_equal(%i[a b c], @graph.get_nodes)
  end

  def test_add_nodes_not_symbol
    assert_raises(TypeError) do
      @graph.add_nodes(%i[a b])
    end
  end

  def test_add_node_not_symbol1
    assert_raises(TypeError) { @graph.add_node(4) }
  end

  def test_add_node_not_symbol2
    assert_raises(TypeError) { @graph.add_node('some_name') }
  end
end
