# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'test_graph'

class TestGraphNodes < TestGraph

  def test_add_node1
    @graph.add_node(:a)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_node2
    @graph.add_node(:b)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:b] })
  end

  def test_add_node3
    @graph.add_node(:a)
    @graph.add_node(Node.new(:b))
    @graph.add_node(:c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_node_existed
    @graph.add_node(:a)
    assert_raises(ArgumentError) { @graph.add_node(:a) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_node_as_node1
    @graph.add_node(Node.new(:c))
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_node_existed_as_node1
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(Node.new(:c)) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_node_existed_as_node2
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(:c) }
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:c] })
  end

  def test_add_nodes1
    @graph.add_nodes(:a)
    assert_node_and_edge_number({ nodes: 1 })
    assert_nodes_and_edges({ nodes: [:a] })
  end

  def test_add_nodes2
    @graph.add_nodes(:a, :b, :c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes3
    @graph.add_nodes(:b, :a, :c)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes4
    @graph.add_nodes(:a, :b, Node.new(:c))
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_add_nodes5
    @graph.add_nodes(%i[a c], %i[w q], :b, :t)
    assert_node_and_edge_number({ nodes: 6 })
    assert_nodes_and_edges({ nodes: %i[t a b c w q] })
  end

  def test_add_nodes_existed
    assert_raises(GraphException) { @graph.add_nodes(:a, :b, Node.new(:b)) }
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_add_nodes_wrong_type
    assert_raises(TypeError) { @graph.add_nodes(:a, Node.new(-1)) }
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_get_nodes1
    assert_nodes_and_edges
  end

  def test_get_nodes2
    @graph.add_nodes(Node.new(:a), :b)
    assert_node_and_edge_number({ nodes: 2 })
    assert_nodes_and_edges({ nodes: %i[a b] })
  end

  def test_nodes_str1
    assert_equal('[]', @graph.nodes_str)
    assert_node_and_edge_number
    assert_nodes_and_edges
  end

  def test_nodes_str2
    @graph.add_nodes(:a, :b, :c)
    assert_equal('[:a, :b, :c]', @graph.nodes_str)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_nodes_str3
    @graph.add_nodes(:a, :c, :b)
    assert_equal('[:a, :c, :b]', @graph.nodes_str)
    assert_node_and_edge_number({ nodes: 3 })
    assert_nodes_and_edges({ nodes: %i[a b c] })
  end

  def test_run_all_tests

  end
end
