require_relative "../models/graph.rb"

module Adapters
  class FormAdapter < Struct.new(:params)
    def self.graph_from(params)
      new(params).graph
    end

    def graph
      graph = Graph.new(nodes, edges, start_nodes, end_nodes)
      set_data_flow_nodes!(graph)
      set_coverage_strategy!(graph)
      graph
    end

    private
    def set_data_flow_nodes!(graph)
      graph.def_nodes = def_nodes
      graph.use_nodes = use_nodes
    end

    def set_coverage_strategy!(graph)
      strategy = eval("CoverageStrategies::" + coverage_strategy_name).new(graph)
      graph.coverage_strategy = strategy
    end

    def coverage_strategy_name
      params[:coverage_type].split("_").map(&:capitalize).join + "Coverage"
    end

    def nodes
      max_node = node_numbers.max
      (0..max_node).map { |id| Node.new(id) }
    end

    def node_numbers
      edges.inject([]) do |nodes, edge|
        nodes = nodes | [edge.source.id]
        nodes = nodes | [edge.destination.id]
      end
    end

    def edges
      params[:edges].split(/\r?\n/).inject([]) do |array, edge|
        nodes_numbers = edge.split(" ")
        array << Edge.new(Node.new(nodes_numbers[0].to_i),
                          Node.new(nodes_numbers[1].to_i))
      end
    end

    def start_nodes
      nodes_from_params_text(params[:start_nodes])
    end

    def end_nodes
      nodes_from_params_text(params[:end_nodes])
    end

    def def_nodes
      nodes_from_params_text(params[:def_nodes])
    end

    def use_nodes
      nodes_from_params_text(params[:use_nodes])
    end

    def nodes_from_params_text(params_text)
      if params_text
        params_text.split(" ").map { |id| Node.new(id.to_i) }
      end
    end
  end
end
