# frozen_string_literal: true

require_relative '../model/edge'
require 'minitest/autorun'

class TestEdge < Minitest::Unit::TestCase
  attr_reader :edge

  def setup
    @edge = Edge.new(:a, :b)
  end

  def test_init_with_node
    @edge = Edge.new(Node.new(:a), Node.new(:b))
  end

  def test_init_with_node_and_symbol
    @edge = Edge.new(:a, Node.new(:b))
  end

  def test_init_raise_exception
    assert_raises(TypeError) { Edge.new(Node.new(:b), 123) }
  end

  def test_equal1
    @edge == Edge.new(:a, :b)
  end

  def test_equal2
    @edge == Edge.new(:b, :a)
  end

  def test_equal3
    new_node = Edge.new(Node.new(:a), Node.new(:b))
    assert_equal(new_node, @edge)
  end

  def test_same
    assert_same(@edge, @edge)
  end

  def test_eql1
    assert(@edge.eql?(Edge.new(:a, :b)))
  end

  def test_eql2
    assert(@edge.eql?(Edge.new(Node.new(:a), Node.new(:b))))
  end

  def test_eql3
    assert_equal(@edge, Edge.new(Node.new(:b), :a))
    assert(@edge.eql?(Edge.new(Node.new(:b), :a)))
  end

  def test_to_s1
    assert_equal('[:a, :b]', @edge.to_s)
  end

  def test_to_s2
    @edge = Edge.new(:b, :a)
    assert_equal('[:b, :a]', @edge.to_s)
  end

  def test_to_s3
    @edge = Edge.new(:a, Node.new(:b))
    assert_equal('[:a, :b]', @edge.to_s)
  end

  def test_to_s4
    @edge = Edge.new(Node.new(:b), Node.new(:a))
    assert_equal('[:b, :a]', @edge.to_s)
  end

  def test_to_a1
    assert_equal(%i[a b], @edge.to_a)
  end

  def test_hash1
    assert_equal(@edge.hash, Edge.new(:a, :b).hash)
  end

  def test_hash2
    assert_equal(@edge.hash, Edge.new(:b, :a).hash)
  end

  def test_hash3
    assert_equal(@edge.hash, Edge.new(Node.new(:a), Node.new(:b)).hash)
  end

  def test_hash4
    assert_equal(@edge.hash, Edge.new(:b, Node.new(:a)).hash)
  end
end
