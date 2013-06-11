require_relative "edge_presenter.rb"

module Presenters
  module Text
    class GraphPresenter < Struct.new(:graph)
      def self.present(graph)
        new(graph).to_text
      end

      def to_text
        [nodes_text, edges_text, start_nodes_text, end_nodes_text,
         def_nodes_text, use_nodes_text].compact.join("<br />")
      end

      private
      def nodes_text
        "Nodes: " + nodes_text_for(graph.nodes)
      end

      def edges_text
        "Edges: " + presented_edges.join(", ")
      end

      def presented_edges
        graph.edges.map { |edge| Presenters::Text::EdgePresenter.present(edge) }
      end

      def start_nodes_text
        "Start nodes: " + nodes_text_for(graph.start_nodes)
      end

      def end_nodes_text
        "End nodes: " + nodes_text_for(graph.end_nodes)
      end

      def def_nodes_text
        "Def nodes: " + nodes_text_for(graph.def_nodes) if graph.def_nodes
      end

      def use_nodes_text
        "Use nodes: " + nodes_text_for(graph.use_nodes) if graph.use_nodes
      end

      def nodes_text_for(nodes)
        nodes.join(", ")
      end
    end
  end
end
