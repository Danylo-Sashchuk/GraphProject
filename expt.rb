# frozen_string_literal: true
require 'set'
require_relative './model/graph'

a = Graph.new
a.add_nodes(:a, :b, Node.new(:c))
