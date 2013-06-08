require_relative "graph_coverage"

class PrimeCoverage < GraphCoverage
  def initialize(graph)
    super(graph, graph.prime_paths)
  end
end
