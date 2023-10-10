# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../model/graph'
require_relative '../utils/utils'

class TestGraph < Minitest::Unit::TestCase
  attr_reader :graph

  def setup
    @graph = Graph.new
  end

  def test_initialize
    check_state
  end

  def test_to_s1
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:b, :c)
    exp = "a -> b\nb -> a, c\nc -> b\n"
    assert_equal(exp, @graph.to_s)
  end

  def test_to_s2
    assert_equal('', @graph.to_s)
  end

  def test_to_s3
    @graph.add_nodes(Utils.some_nodes)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    @graph.add_edge(:a, :e)
    @graph.add_edge(:b, :j)
    assert_equal("a -> b, c, e\nb -> a, j\nc -> a\nd -> \ne -> a\nf -> \ng -> \nh -> \ni -> \nj -> b\nk -> \nl -> \nm -> \nn -> \no -> \n", @graph.to_s)
  end

  def test_equal1
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    @graph.add_edge(:b, :c)

    equal_graph = Graph.new
    equal_graph.add_nodes(:a, :b, :c)
    equal_graph.add_edge(:a, :b)
    equal_graph.add_edge(:a, :c)
    equal_graph.add_edge(:b, :c)

    assert_equal(equal_graph, @graph)
  end

  def test_equal2
    assert_equal(Graph.new, @graph)
  end

  def test_equal3
    not_a_graph = 'I am a Graph. Really!'
    refute(@graph == not_a_graph)
  end

  def test_equal4
    @graph.add_nodes(:a, :b, :c)
    @graph.add_edge(:a, :b)
    @graph.add_edge(:a, :c)
    @graph.add_edge(:b, :c)

    equal_graph = Graph.new
    equal_graph.add_nodes(:a, :b, :c)
    equal_graph.add_edge(:a, :b)
    equal_graph.add_edge(:a, :c)
    equal_graph.add_edge(:b, :c)

    assert(equal_graph == @graph)
  end

  def test_equal5
    assert_equal(@graph, @graph)
  end

  def test_equal6
    assert(@graph == @graph)
  end

  def test_same
    assert_same(@graph, @graph)
  end

  def test_duplicate_objects
    a = Node.new(:a)
    b = Node.new(:b)
    c = Node.new(:c)
    d = Node.new(:d)
    e = Node.new(:e)

    @graph.add_nodes(a, b, c, d, e)
    @graph.add_edge(:a, b)
    @graph.add_edge(c, Node.new(:a))
    node_a_id_as_key = @graph.nodes.find { |node| node.name == :a }.object_id
    node_a_id_in_value = @graph.adjacency_list[c][0].object_id
    assert_equal(node_a_id_as_key, node_a_id_in_value)
  end

  def test_edge_exist1
    a = Node.new(:a)
    b = Node.new(:b)

    @graph.add_nodes(a, b)
    @graph.add_edge(b, a)

    captured_output = capture_io do
      @graph.add_edge(a, b)
    end
    assert_match('Edge between a and b already exist.', captured_output.join)
  end

  def test_edge_between_same_node
    @graph.add_nodes(:a, :b)
    captured_output = capture_io do
      @graph.add_edge(:a, :a)
    end
    assert_match('Cannot add an edge between the same node a.', captured_output.join)
  end

  def check_state(args = {})
    args[:graph] = @graph
    assert(Utils.check_state(args))
  end
end
