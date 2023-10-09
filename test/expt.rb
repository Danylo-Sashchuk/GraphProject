# frozen_string_literal: true

require 'set'
require_relative '../model/graph'
require_relative '../utils/graph_utils'

# a = Node.new(:a)
# b = Node.new(:b)
# c = Node.new(:c)
# d = Node.new(:d)
# e = Node.new(:e)
#
# graph = Graph.new
# graph.add_nodes(a, b, c, d, e)
# graph.add_edge(a, b)
# graph.add_edge(a, c)
# graph.add_edge(d, e)

g = GraphUtils.genCompleteGraph(10, 0.5)
puts g
puts "pause here"
