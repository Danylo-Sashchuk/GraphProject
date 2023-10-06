# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../model/node'

class TestNode < Minitest::Unit::TestCase
  attr_reader :node

  def setup
    @node = Node.new(:a)
  end

  def test_init
    Node.new("a")
  end

  def test_equal
    assert_equal(@node, Node.new(:a))
  end

  def test_same
    assert_same(@node, @node)
  end

  def test_to_s
    assert_equal('a', @node.to_s)
  end

  def test_hash1
    assert(@node.hash == Node.new(:a).hash)
  end

  def test_hash2
    assert(@node.hash == Node.new(:a).hash)
  end

  def test_eql1
    assert(@node.eql?(Node.new(:a)))
  end

  def test_eql2
    assert(@node.eql?(@node))
  end

  def test_eql3
    refute(@node.eql?('String'))
  end

  def test_init_type_error
    assert_raises(TypeError) { Node.new('String') }
  end
end
