# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

graph = GraphUtils.genCompleteGraph(10, 0.1)
dfs = GraphUtils.dfs(graph, :v3)
GraphUtils.genSubGraph(graph, dfs)
