# frozen_string_literal: true
require 'set'
require_relative './model//graph'

g = Graph.new
g.add_nodes(:a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l, :m, :n, :o) # 15
g.add_edge(:a, :b)
g.add_edge(:a, :c)
g.add_edge(:a, :e)
g.add_edge(:b, :j)
puts g
