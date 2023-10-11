# frozen_string_literal: true

# Graph
require_relative './utils/graph_utils'

g = Graph.new

a = Node.new(:a)
# a = Node.new(123)
b = Node.new(:b)

g.add_node(a)
g.add_nodes(b, :c, :d)
print g
g.add_nodes(:q, Node.new(:l), Node.new(:w), 123)
puts g
puts

g.add_edge(a, b)
g.add_edge(:b, :d)
print("#{g}\n")

#---------------------------------

compl = GraphUtils.genCompleteGraph(10)
print("#{compl}\n")

compl = GraphUtils.genCompleteGraph(10, 0.3)
print("#{compl}\n")

#-----------------------------------
dfs = GraphUtils.dfs(compl, :v2)
print("#{dfs}\n")

#-----------------------------------
compl.render('pres', [400, 400], 200)
GraphUtils.genCompleteGraph(15).render('pres2', [400, 400], 200)

#-----------------------------------
main_graph = GraphUtils.genCompleteGraph(15, 0.1)
dfs = GraphUtils.dfs(main_graph, :v1)
sub_graph_v1 = GraphUtils.genSubGraph(main_graph, dfs)
sub_graph_v2 = GraphUtils.genSubGraph(main_graph, GraphUtils.dfs(main_graph, :v14))
main_graph.layout_circular([400, 400], 200)

GraphUtils.render_graphs('main_graph', [[main_graph, 'yellow', 'brown']])
GraphUtils.render_graphs('sub_graph_v1', [[sub_graph_v1, 'green', 'blue']])

GraphUtils.render_graphs('sub_graph_v1_on_main', [[main_graph, 'red', 'red'], [sub_graph_v1, 'green', 'blue']])

GraphUtils.render_graphs('sub_graph_v2', [[sub_graph_v2, 'pink', 'blue']])
GraphUtils.render_graphs('2_sub_graphs_on_main', [[main_graph, 'red', 'red'], [sub_graph_v1, 'green', 'blue'], [sub_graph_v2, 'purple', 'yellow']])
print("#{sub_graph_v1}\n")
print("#{sub_graph_v2}\n")
print("#{main_graph}\n")
