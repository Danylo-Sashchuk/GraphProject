# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../utils/utils'
require_relative 'test_graph'

class TestGraphNodes < TestGraph

  def test_add_node1
    @graph.add_node(:a)
    check_state({ nodes_nbr: 1, nodes: [:a] })
  end

  def test_add_node2
    @graph.add_node(:b)
    check_state({ nodes_nbr: 1, nodes: [:b] })
  end

  def test_add_node3
    @graph.add_node(:a)
    @graph.add_node(Node.new(:b))
    @graph.add_node(:c)
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end

  def test_add_node_existed
    @graph.add_node(:a)
    assert_raises(ArgumentError) { @graph.add_node(:a) }
    check_state({ nodes_nbr: 1, nodes: [:a] })
  end

  def test_add_node_as_node1
    @graph.add_node(Node.new(:c))
    check_state({ nodes_nbr: 1, nodes: [:c] })
  end

  def test_add_node_existed_as_node1
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(Node.new(:c)) }
    check_state({ nodes_nbr: 1, nodes: [:c] })
  end

  def test_add_node_existed_as_node2
    @graph.add_node(Node.new(:c))
    assert_raises(ArgumentError) { @graph.add_node(:c) }
    check_state({ nodes_nbr: 1, nodes: [:c] })
  end

  def test_add_nodes1
    @graph.add_nodes(:a)
    check_state({ nodes_nbr: 1, nodes: [:a] })
  end

  def test_add_nodes2
    @graph.add_nodes(:a, :b, :c)
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end

  def test_add_nodes3
    @graph.add_nodes(:b, :a, :c)
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end

  def test_add_nodes4
    @graph.add_nodes(:a, :b, Node.new(:c))
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end

  def test_add_nodes5
    @graph.add_nodes(%i[a c], %i[w q], :b, :t)
    check_state({ nodes_nbr: 6, nodes: %i[t a b c w q] })
  end

  def test_add_nodes_existed
    assert_raises(GraphException) { @graph.add_nodes(:a, :b, Node.new(:b)) }
    check_state
  end

  def test_add_nodes_wrong_type
    assert_raises(TypeError) { @graph.add_nodes(:a, Node.new(-1)) }
    check_state
  end

  def test_get_nodes1
    check_state
  end

  def test_get_nodes2
    @graph.add_nodes(Node.new(:a), :b)
    check_state({ nodes_nbr: 2, nodes: %i[a b] })
  end

  def test_nodes_str1
    assert_equal('[]', @graph.nodes_str)
    check_state
  end

  def test_nodes_str2
    @graph.add_nodes(:a, :b, :c)
    assert_equal('[:a, :b, :c]', @graph.nodes_str)
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end

  def test_nodes_str3
    @graph.add_nodes(:a, :c, :b)
    assert_equal('[:a, :c, :b]', @graph.nodes_str)
    check_state({ nodes_nbr: 3, nodes: %i[a b c] })
  end
end
