# frozen_string_literal: true

require 'victor'

class GraphRenderer
  attr_accessor :node_color, :s_color

  def calculate_nodes_coordinates
    @nodes_coordinates = {}
    @nodes.each do |node|
      angle = @nodes.index(node) * angle_between_nodes
      @nodes_coordinates[node.name] = calculate_node_coordinates(angle)
    end
  end

  def initialize(center, radius, nodes)
    @nodes = nodes
    @center = center
    @radius = radius
    @node_radius = 10
    @visited_nodes = Set.new
    @node_color = 'blue'
    @s_color = 'red'
    setup_canvas
    calculate_nodes_coordinates
  end

  def render(adjacency_list)
    @adjacency_list = adjacency_list
    @visited_nodes = Set.new
    # @nodes = adjacency_list.keys
    @nodes.each do |node|
      # Skip already visited nodes to prevent duplicate lines
      next if @visited_nodes.include?(node)

      draw_node(node)
      draw_edges(node)
      @visited_nodes << node
    end
  end

  def save(filename)
    @svg.save("output/#{filename}")
  end

  def setup_canvas
    padding = 20

    canvas_width = 2 * (@radius + @node_radius + padding)
    canvas_height = 2 * (@radius + @node_radius + padding)

    @center[0] = [@center[0], @radius + @node_radius + padding, canvas_width - @radius - @node_radius - padding].sort[1]
    @center[1] = [@center[1], @radius + @node_radius + padding, canvas_height - @radius - @node_radius - padding].sort[1]

    @svg = Victor::SVG.new(viewBox: "0 0 #{canvas_width} #{canvas_height}", style: { background: 'white' })
  end

  def angle_between_nodes
    360.0 / @nodes.length
  end

  def calculate_node_coordinates(angle)
    node_x = @center[0] + @radius * Math.cos(angle * Math::PI / 180)
    node_y = @center[1] + @radius * Math.sin(angle * Math::PI / 180)
    [node_x, node_y]
  end

  def draw_node(node)
    @svg.circle(cx: @nodes_coordinates[node.name][0], cy: @nodes_coordinates[node.name][1], r: @node_radius, fill: node_color)
  end

  def draw_edges(node)
    angle = @nodes.index(node) * angle_between_nodes
    node_x, node_y = calculate_node_coordinates(angle)

    @visited_nodes.each do |visited_node|
      next if visited_node == node

      next unless @adjacency_list[node]&.include?(visited_node)

      visited_index = @nodes.index(visited_node)
      adjacent_x, adjacent_y = calculate_node_coordinates(visited_index * angle_between_nodes)

      @svg.line(x1: node_x, y1: node_y, x2: adjacent_x, y2: adjacent_y, stroke: s_color, 'stroke-width': 1)
    end
  end

  def add_render(adjacency_list, node_color, s_color)
    @node_color = node_color
    @s_color = s_color
    render(adjacency_list)
  end
end
