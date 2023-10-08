# frozen_string_literal: true
require 'set'
require_relative './model/graph'

a = Graph.new
a.add_nodes(:a, :b, :q)
a.add_edge(:a, :b)
a.add_edge(:a, :q)
puts a.edges_str
