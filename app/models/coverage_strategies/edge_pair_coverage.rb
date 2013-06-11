require_relative "graph_coverage"

module CoverageStrategies
  class EdgePairCoverage < GraphCoverage
    def initialize(graph)
      super(graph, graph.edge_pair_paths)
    end
  end
end
