# frozen_string_literal: true

require 'victor'

class GraphRenderer
  def initialize(nodes, adjacency_list, center, radius)
    @nodes = nodes
    @adjacency_list = adjacency_list
    @center = center
    @radius = radius
  end

  def setup_canvas(node_radius, padding)
    canvas_width = 2 * (@radius + node_radius + padding)
    canvas_height = 2 * (@radius + node_radius + padding)

    @center[0] = [@center[0], @radius + node_radius + padding, canvas_width - @radius - node_radius - padding].sort[1]
    @center[1] = [@center[1], @radius + node_radius + padding, canvas_height - @radius - node_radius - padding].sort[1]

    @svg = Victor::SVG.new(viewBox: "0 0 #{canvas_width} #{canvas_height}", style: { background: 'white' })
  end

  def render(filename)
    angle_between_nodes = 360.0 / @nodes.length
    padding = 20
    node_radius = 10

    setup_canvas(node_radius, padding)

    @nodes.each_with_index do |node, index|
      angle = index * angle_between_nodes

      node_x = @center[0] + @radius * Math.cos(angle * Math::PI / 180)
      node_y = @center[1] + @radius * Math.sin(angle * Math::PI / 180)

      @svg.circle(cx: node_x, cy: node_y, r: node_radius, fill: 'blue')

      @adjacency_list[node].each do |adjacent_node|
        adjacent_index = @nodes.index(adjacent_node)
        adjacent_angle = adjacent_index * angle_between_nodes
        adjacent_x = @center[0] + @radius * Math.cos(adjacent_angle * Math::PI / 180)
        adjacent_y = @center[1] + @radius * Math.sin(adjacent_angle * Math::PI / 180)

        @svg.line(x1: node_x, y1: node_y, x2: adjacent_x, y2: adjacent_y, stroke: 'red', 'stroke-width': 1)
      end
    end

    @svg.save("output/#{filename}")
  end
end
