require_relative "graph_coverage"

module CoverageStrategies
  class NodeCoverage < GraphCoverage
    def initialize(graph)
      super(graph, paths_from_nodes(graph))
    end

    def covering_test
      paths = graph.nodes.collect do |node|
        path_through(node)
      end

      return nil if paths.any?(&:nil?)

      Test.new(paths.uniq)
    end

    private
    def path_through(node)
      if graph.path_from_start_to(node) && graph.path_to_end_from(node)
        nodes = graph.path_from_start_to(node).nodes
        nodes.concat(graph.path_to_end_from(node).nodes[1..-1])
        Path.new(nodes)
      end
    end

    def paths_from_nodes(graph)
      graph.nodes.map { |node| Path.new([node]) }
    end
  end
end
