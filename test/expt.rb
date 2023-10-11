# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

# g = Graph.new
# g.add_nodes(:a, :b, :q, :p, :k)
# g.add_edge(:b, :a)
# g.add_edge(:b, :k)
# g.add_edge(:p, :q)
# g.render("ilya", [400, 400], 200)


c24 = GraphUtils.genCompleteGraph(10, 0.2)
c24.layout_circular([400, 400], 200)

GraphUtils.render_graphs("one", [[c24, 'green', 'blue']])

ns = GraphUtils.dfs c24, :v0

c24v0 = GraphUtils.genSubGraph c24, ns

print c24
puts
print (c24v0)

GraphUtils.render_graphs 'c24v0.svg', [[c24, 'green', 'blue'], [c24v0, 'red', 'yellow']]

david = GraphUtils.genCompleteGraph(3)
david.render("david", [400,400], 200)



