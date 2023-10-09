# frozen_string_literal: true
require_relative '../model/graph'

class GraphUtils
  def self.genCompleteGraph(n, p = 1)
    graph = Graph.new
    nodes = n.times.map { |i| "v#{i}".to_sym }
    graph.add_nodes(nodes) # TODO: here it creates nodes

    nodes.combination(2).each { |pair| graph.add_edge(pair[0], pair[1]) if rand < p } # TODO: and here it does again
    graph
  end

  def self.dfs(graph, node)
    visited = Set.new
    dfs_rec(node, visited)
    visited
  end

  private

  def self.dfs_rec(node, visited)
    visited.add(node)

  end
end
