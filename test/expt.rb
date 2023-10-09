# frozen_string_literal: true

require 'set'
require_relative '../model/graph'
require_relative '../utils/graph_utils'

g = GraphUtils.genCompleteGraph(10, 0.005)
puts g
puts g.nodes_str
puts g.edges_str
puts g.nbr_edges
puts g.nbr_nodes
