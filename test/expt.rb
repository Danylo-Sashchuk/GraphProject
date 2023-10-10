# frozen_string_literal: true
require_relative '../model/graph'
require_relative '../utils/graph_utils'
require 'victor'

graph = GraphUtils.genCompleteGraph(10, 0.5)
nodes = graph.nodes
adjacency_list = graph.adjacency_list

total_nodes = nodes.length
angle_between_nodes = 360.0 / total_nodes

# Create a new SVG document
svg = Victor::SVG.new(width: 1000, height: 1000, viewBox: '0 0 1000 1000', style: { background: 'white' })

# Define the center coordinates of the circle
center_x = 500
center_y = 500

# Define the radius of the circle
radius = 300

nodes.each_with_index do |node, index|
  # Calculate the angle for the current node
  angle = index * angle_between_nodes

  # Calculate the coordinates for the node position on the circle
  node_x = center_x + radius * Math.cos(angle * Math::PI / 180)
  node_y = center_y + radius * Math.sin(angle * Math::PI / 180)

  # Create a circle for each node
  svg.circle(cx: node_x, cy: node_y, r: 20, fill: 'blue')

  # Loop through the adjacent nodes and draw edges
  adjacency_list[node].each do |adjacent_node|
    adjacent_index = nodes.index(adjacent_node)
    adjacent_angle = adjacent_index * angle_between_nodes
    adjacent_x = center_x + radius * Math.cos(adjacent_angle * Math::PI / 180)
    adjacent_y = center_y + radius * Math.sin(adjacent_angle * Math::PI / 180)

    # Draw an edge (line) between the current node and its adjacent node
    svg.line(x1: node_x, y1: node_y, x2: adjacent_x, y2: adjacent_y, stroke: 'red', 'stroke-width': 1)
  end

end

svg.save('graphs')
