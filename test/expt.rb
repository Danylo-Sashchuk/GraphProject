# frozen_string_literal: true

require 'set'
require_relative '../model/graph'
require_relative '../utils/graph_utils'

a = Node.new(:a)
b = Node.new(:b)
c = Node.new(:c)
d = Node.new(:d)
e = Node.new(:e)

graph = Graph.new
graph.add_node(a)
graph.add_node(b)
graph.add_node(c)
graph.add_node(d)
graph.add_node(e)
graph.add_edge(a, b)
graph.add_edge(a, c)
graph.add_edge(d, e)

puts graph
puts graph.nodes_str
puts graph.edges_str
puts graph.nbr_edges
puts graph.nbr_nodes

