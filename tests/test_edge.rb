# frozen_string_literal: true

require_relative '../model/edge'
require 'minitest/autorun'

class TestEdge < Minitest::Unit::TestCase
  attr_reader :edge

  def setup
    @edge = Edge.new(:a, :b)
  end

  def test_equal1
    @edge == Edge.new(:a, :b)
  end

  def test_equal2
    @edge == Edge.new(:b, :a)
  end

  def test_same
    assert_same(@edge, @edge)
  end

  def test_to_s1
    assert_equal('[a, b]', @edge.to_s)
  end

  def test_to_s2
    @edge = Edge.new(:b, :a)
    assert_equal('[b, a]', @edge.to_s)
  end
end
