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
    visited.keys.map(&:name)
  end

  def self.genSubGraph(main_graph, sub_graph)
    new_graph = Graph.new

    main_graph.nodes.each do |node|
      new_node = Node.new(node.name)
      new_graph.add_node(new_node)

      if sub_graph.include?(node.name)
        new_node.instance_variable_set(:@visible, true)
        neighbors = main_graph.adjacency_list[node] || []
        neighbors.each do |neighbor|
          if sub_graph.include?(neighbor.name) && new_graph.nodes_pool.include?(neighbor.name)
            new_graph.add_edge(new_node, neighbor)
          end
        end
      else
        new_node.instance_variable_set(:@visible, false)
      end
    end

    new_graph.render("in-vis", [400, 400], 200)
  end

  private

  def self.dfs_rec(node, visited, adj_list)
    return if visited[node]

    visited[node] = true

    neighbors = adj_list[node] || []
    neighbors.each do |neighbor|
      dfs_rec(neighbor, visited, adj_list)
    end
  end
end
