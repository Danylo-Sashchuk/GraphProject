# frozen_string_literal: true

require_relative 'node'

class Graph
  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def add_node(node)
    @nodes << if node.is_a?(Node)
                node
              else
                Node.new(node)
              end
  end

  def add_nodes(*nodes)
    nodes.each { |node| add_node(node) }
  end

  def get_nodes
    output = []
    nodes.each { |node| output << node.name }
    output
  end
end
