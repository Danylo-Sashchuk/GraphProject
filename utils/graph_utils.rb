# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../model/node'

class GraphUtils
  def self.genCompleteGraph(n, p = 1)
    graph = Graph.new
    nodes = n.times.map { |i| "v#{i}".to_sym }
    graph.add_nodes(nodes)

    nodes.combination(2).each { |pair| graph.add_edge(pair[0], pair[1]) if rand < p }
    graph
  end

  def self.dfs(graph, node)
    visited = {}
    node = Node.ensure_node(node)
    dfs_rec(node, visited, graph.adjacency_list)
    visited.keys.to_a.map(&:name)
  end

  def self.dfs_rec(node, visited, adj_list)
    return if visited[node]

    visited[node] = true

    neighbors = adj_list[node] || []
    neighbors.each do |neighbor|
      dfs_rec(neighbor, visited, adj_list)
    end

  end
end
