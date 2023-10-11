# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

graph = GraphUtils.genCompleteGraph(10, 0.2)
dfs = GraphUtils.dfs(graph, :v3)
sub_graph = GraphUtils.genSubGraph(graph, dfs)
sub_graph.render('smth', [400, 400], 200)
