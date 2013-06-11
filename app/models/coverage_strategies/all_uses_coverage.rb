require_relative "graph_coverage"

module CoverageStrategies
  class AllUsesCoverage < GraphCoverage
    def initialize(graph)
      super(graph, graph.all_uses_paths)
    end
  end
end
