# Graph Project

A Ruby project for graph visualizations and working with them.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
- [Usage](#usage)

## Introduction

The Graph Project is a Ruby library for working with graphs. It provides classes and methods for creating, manipulating,
and visualizing graphs, as well as performing common graph-related tasks.

## Features

Key features of the Graph Project include:

- Graph creation and manipulation.
- Depth-First Search (DFS) algorithm implementation.
- Subgraph generation from visited nodes.
- A circular visualization of graphs in SVG format.
- A circular visualization of a set of graphs in SVG format.

## Getting Started

### Prerequisites

Before you begin, ensure you have the following prerequisites:

- Ruby (version 3.2.0)
- [Victor](https://github.com/DannyBen/victor)

### Installation

```shell
git clone https://github.com/Danylo-Sashchuk/GraphProject.git

cd graph-project
```

## Usage

```ruby
my_graph = Graph.new

node_a = Node.new(:a) # create a node instance. Name must be a symbol.

my_graph.add_node(node_a)
my_graph.add_node(:b) # adds a node to the graph.

my_graph.add_edge(node_a, :b) # adds an edge.

# GraphUtils class
dfs_res = GraphUtils.dfs(my_graph, :a)

complete_graph = GraphUtils.genCompleteGraph(10)

uncompleted_graph = GraphUtils.genCompleteGraph(10, 0.2)

sub_graph = GraphUtils.genSubGraph(complete_graph, dfs_res)

# Generate SVGs. Default folder is 'output'

main_graph = GraphUtils.genCompleteGraph(15, 0.1)
dfs = GraphUtils.dfs(main_graph, :v1)
sub_graph_v1 = GraphUtils.genSubGraph(main_graph, dfs)
sub_graph_v2 = GraphUtils.genSubGraph(main_graph, GraphUtils.dfs(main_graph, :v14))
main_graph.layout_circular([400, 400], 200)

GraphUtils.render_graphs('main_graph', [[main_graph, 'yellow', 'brown']])
GraphUtils.render_graphs('sub_graph_v1', [[sub_graph_v1, 'green', 'blue']])
GraphUtils.render_graphs('sub_graph_v2', [[sub_graph_v2, 'black', 'blue']])


GraphUtils.render_graphs('sub_graph_v1_on_main', [[main_graph, 'red', 'red'], [sub_graph_v1, 'green', 'blue']])
GraphUtils.render_graphs('2_sub_graphs_on_main', [[main_graph, 'red', 'red'], [sub_graph_v1, 'green', 'blue'], [sub_graph_v2, 'purple', 'orange']])
```
