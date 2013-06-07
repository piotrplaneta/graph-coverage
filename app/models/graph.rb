require_relative "graph_extensions/bfs"
require_relative "graph_extensions/edge_pair_paths_generator"
require_relative "graph_extensions/prime_paths_generator"
require_relative "graph_extensions/data_flow"

class Graph < Struct.new(:nodes, :edges, :start_nodes, :end_nodes)
  include Extensions::Bfs
  include Extensions::EdgePairPathsGenerator
  include Extensions::PrimePathsGenerator
  include Extensions::DataFlow

  def add_node(node)
    nodes << node
  end

  def delete_node(node)
    nodes.delete(node)
  end

  def add_edge(edge)
    edges << edge
  end

  def delete_edge(edge)
    edges.delete(edge)
  end

  def add_node(node)
    nodes << node
  end

  def delete_node(node)
    nodes.delete(node)
  end

  def add_start_node(node)
    start_nodes << node
  end

  def delete_start_node(node)
    start_node.delete(node)
  end

  def add_end_node(node)
    end_nodes << node
  end

  def delete_end_node(node)
    end_nodes.delete(node)
  end

  def validate_start_and_end(path)
    start_nodes.include?(path.nodes[0]) &&
      end_nodes.include?(path.nodes[-1])
  end

  def validate(path)
    path.nodes.each_cons(2).all? do |node_pair|
      edges.include?(Edge.new(node_pair[0], node_pair[1]))
    end
  end
end
