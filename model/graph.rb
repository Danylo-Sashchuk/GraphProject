# frozen_string_literal: true
require_relative 'node'

class Graph
  attr_reader :nodes

  def initialize
    @nodes = []
  end

  def add_node(name)
    @nodes << Node.new(name)
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
