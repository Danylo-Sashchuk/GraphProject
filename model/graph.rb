# frozen_string_literal: true

require_relative '../exceptions/graph_exception'
require_relative 'node'
require 'set'
require 'victor'

class Graph
  attr_reader :adjacency_list

  def initialize
    @adjacency_list = {}
    @nodes_pool = {}
  end

  def add_node(node)
    node = Node.ensure_node(node)
    raise ArgumentError, "Node #{node} is already in the graph" if @adjacency_list.key?(node)

    @adjacency_list[node] = []
    @nodes_pool[node.name] = node
  end

  def add_nodes(*nodes)
    added_nodes = []
    begin
      nodes.flatten.each do |node|
        node = Node.ensure_node(node)
        add_node(node)
        added_nodes << node
      end
    rescue StandardError => e
      # Rollback the graph if one of the received nodes is wrong
      added_nodes.each do |node|
        @adjacency_list.delete(node)
        @nodes_pool.delete(node.name)
      end
      raise GraphException, "Exception occurred. Rollback the graph's nodes. \n#{e.message}"
    end
  end

  def nodes_str
    nodes = @adjacency_list.keys.map(&:name)
    "[#{nodes.join(', ')}]"
  end

  def nbr_nodes
    @adjacency_list.keys.size
  end

  def nodes
    @adjacency_list.keys
  end

  def check_edge_constraints(node_a, node_b)
    raise GraphException, 'One of the nodes does not belong to the graph.' if node_a.nil? || node_b.nil?

    raise GraphException, "Cannot add an edge between the same node #{node_a}." if node_a == node_b

    raise GraphException, "Edge between #{node_a} and #{node_b} already exist." if edge_exists?(node_a, node_b)
  end

  def add_edge(node_a, node_b)
    node_a = Node.ensure_node(node_a)
    node_b = Node.ensure_node(node_b)

    node_a = @nodes_pool[node_a.name]
    node_b = @nodes_pool[node_b.name]

    begin
      check_edge_constraints(node_a, node_b)
      @adjacency_list[node_a] << node_b
      @adjacency_list[node_b] << node_a
    rescue GraphException => e
      print(e.message)
    end
  end

  def edge_exists?(node_a, node_b)
    @adjacency_list[node_a].include?(node_b) || @adjacency_list[node_b].include?(node_a)
  end

  def edges_str
    raw_edges = edges.to_a
    output = raw_edges.map { |array| "[#{array[0]}, #{array[1]}]" }.join(', ')
    "[#{output}]"
  end

  def nbr_edges
    edges = 0
    @adjacency_list.each do |_node, neighbors|
      edges += neighbors.length
    end
    edges / 2
  end

  def edges
    edges = Set.new
    @adjacency_list.each do |node, neighbors|
      neighbors.each { |neighbor| edges << [node.name, neighbor.name].sort }
    end
    edges
  end

  def to_s
    result = ''
    adjacency_list.each do |node, neighbors|
      result += "#{node} -> #{neighbors.join(', ')}\n"
    end
    result
  end

  def ==(other)
    return false unless other.is_a?(Graph)

    self_adjacency_set = adjacency_set
    other_adjacency_set = other.adjacency_set

    self_adjacency_set == other_adjacency_set
  end

  def adjacency_set
    set = {}
    @adjacency_list.each do |node, neighbors|
      set[node] = Set.new(neighbors)
    end
    set
  end

  def render(filename, center, radius)
    # Calculate the viewBox values based on your circular layout
    node_radius = 10 # Adjust this value as needed
    viewbox_width = 3 * radius
    viewbox_height = 3 * radius
    radius = [radius, [viewbox_width - center[0], viewbox_height - center[1]].min - node_radius].min - 30
    center[0] = [node_radius, [center[0], viewbox_width - node_radius].min].max
    center[1] = [node_radius, [center[1], viewbox_height - node_radius].min].max
    viewbox_x = center[0] - radius + 30
    viewbox_y = center[1] - radius + 30

    # Create an SVG document with the calculated viewBox
    svg = Victor::SVG.new(width: viewbox_width, height: viewbox_height,
                          viewBox: "#{viewbox_x} #{viewbox_y} #{viewbox_width} #{viewbox_height}
                          ", style: { background: 'white' })

    total_nodes = nodes.length
    angle_between_nodes = 360.0 / total_nodes

    nodes.each_with_index do |node, index|
      # Calculate the angle for the current node
      angle = index * angle_between_nodes

      # Calculate the coordinates for the node position on the circle
      node_x = center[0] + radius * Math.cos(angle * Math::PI / 180)
      node_y = center[1] + radius * Math.sin(angle * Math::PI / 180)

      # Create a circle for each node
      svg.circle(cx: node_x, cy: node_y, r: node_radius, fill: 'blue')

      # Loop through the adjacent nodes and draw edges
      adjacency_list[node].each do |adjacent_node|
        adjacent_index = nodes.index(adjacent_node)
        adjacent_angle = adjacent_index * angle_between_nodes
        adjacent_x = center[0] + radius * Math.cos(adjacent_angle * Math::PI / 180)
        adjacent_y = center[1] + radius * Math.sin(adjacent_angle * Math::PI / 180)

        # Draw an edge (line) between the current node and its adjacent node
        svg.line(x1: node_x, y1: node_y, x2: adjacent_x, y2: adjacent_y, stroke: 'red', 'stroke-width': 1)
      end
    end
    svg.save(filename)
  end
end
