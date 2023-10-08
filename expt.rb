# frozen_string_literal: true
require 'set'
require_relative './model/graph'

a = Graph.new
a.add_nodes(:a, :b)
a.add_edge(:a, :b)
edge = Edge.new(:a, :b)
puts edge
