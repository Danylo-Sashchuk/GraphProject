# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

c24 = GraphUtils.genCompleteGraph(10, 0.2)
c24.layout_circular([400, 400], 200)

# GraphUtils.render_graphs("one", [[c24, 'green', 'blue']])

ns = GraphUtils.dfs c24, :v0

c24v0 = GraphUtils.genSubGraph c24, ns

print (c24v0)
puts
print c24

GraphUtils.render_graphs 'c24v0.svg', [[c24, 'green', 'blue'], [c24v0, 'red', 'red']]



