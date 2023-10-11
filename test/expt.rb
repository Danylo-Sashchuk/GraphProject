# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

graph = GraphUtils.genCompleteGraph(10)
graph.render('comparable_graph123', [200, 200], 400)
print graph.nbr_edges
