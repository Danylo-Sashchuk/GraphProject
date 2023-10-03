# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../node'

class TestNode < Minitest::Unit::TestCase
  attr_reader :node

  def setup
    @node = Node.new(:a)
  end

  def test_equal
    assert_equal(@node, Node.new(:a))
  end

  def test_same
    assert_equal(@node, @node)
  end

  def test_to_s
    assert_equal('a', @node.to_s)
  end
end
