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
    populate_graph(main_graph, new_graph, sub_graph)
    new_graph
  end

  private_class_method :populate_graph, :add_neighbors, :set_visibility,
                       :node_was_added?, :node_in_sub_graph?, :dfs_rec

  def self.populate_graph(main_graph, new_graph, sub_graph)
    main_graph.nodes.each do |node|
      new_node = Node.new(node.name)
      new_graph.add_node(new_node)
      set_visibility(new_node, sub_graph.include?(node.name))
      add_neighbors(main_graph, new_graph, new_node, sub_graph)
    end
  end

  def self.add_neighbors(main_graph, new_graph, node, sub_graph)
    neighbors = main_graph.adjacency_list[node] || []
    neighbors.each do |neighbor|
      if node_in_sub_graph?(node, neighbor, sub_graph) && node_was_added?(neighbor, new_graph)
        new_graph.add_edge(node, neighbor)
      end
    end
  end

  def self.set_visibility(node, value)
    node.instance_variable_set(:@visible, value)
  end

  def self.node_was_added?(neighbor, new_graph)
    new_graph.nodes_pool.key?(neighbor.name)
  end

  def self.node_in_sub_graph?(neighbor, node, sub_graph)
    sub_graph.include?(node.name) && sub_graph.include?(neighbor.name)
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
