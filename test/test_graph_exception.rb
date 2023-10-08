# frozen_string_literal: true
require 'minitest/autorun'
require_relative '../exceptions/graph_exception'

class TestGraphException < Minitest::Unit::TestCase

  def test_1
    exceptional_method
  rescue GraphException => e
    assert(e.message_with_details.start_with?("GraphException occurred:\n  Class: TypeError\n  Message: I am TypeError. And I am happened. Your fault.\n  Backtrace:"))
  end

  def test_2
    lower_exception
  rescue GraphException => e
    assert_equal(e.message_with_details, "GraphException occurred:\n  No underlying exception details available.\n")
  end

  private

  def method_down_there
    raise TypeError, 'I am TypeError. And I am happened. Your fault.'
  end

  def exceptional_method
    method_down_there
  rescue TypeError => e
    raise GraphException.new 'Graph is wrong!', e
  end

  def lower_exception
    method_down_there
  rescue TypeError
    raise GraphException, 'Graph is wrong!'
  end
end
