require_relative "graph_coverage"

class AllUsesCoverage < GraphCoverage
  def initialize(graph)
    super(graph, graph.all_uses_paths)
  end
end
